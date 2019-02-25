set ns [new Simulator]

set tracefile [open 3.tr w]
$ns trace-all $tracefile

set namfile [open 3.nam w]
$ns namtrace-all $namfile

proc finish {} {
		global ns tracefile namfile
		$ns flush-trace
		
		close $tracefile
		close $namfile
		exec awk -f stats3.awk 3.tr &
		exec nam 3.nam &
		exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 0.5Mb 20ms DropTail
$ns duplex-link $n1 $n2 0.5Mb 20ms DropTail
$ns duplex-link $n2 $n3 0.5Mb 20ms DropTail

$ns queue-limit $n0 $n2 10

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP


set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0
set null0 [new Agent/Null]
$ns attach-agent $n3 $null0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

$ns connect $udp0 $null0 
$ns connect $tcp0 $sink0

$ns at 0.5 "$ftp0 start"
$ns at 1.0 "$cbr0 start"
$ns at 9.0 "$cbr0 stop"
$ns at 9.5 "$ftp0 stop"
$ns at 10.0 "finish"
$ns run
