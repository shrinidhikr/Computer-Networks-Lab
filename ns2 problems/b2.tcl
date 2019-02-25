set ns [new Simulator]

set tracefile [open 2.tr w]
$ns trace-all $tracefile

set namfile [open 2.nam w]
$ns namtrace-all $namfile

proc finish {} {
		global ns namfile tracefile
		$ns flush-trace
		
		close $tracefile
		close $namfile
		exec awk -f stats2.awk 2.tr &
		exec nam 2.nam &
		exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 900kb 10ms DropTail

$ns queue-limit $n0 $n2 10

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0

set telnet [new Application/Telnet]
$telnet attach-agent $tcp0
$telnet set interval_ 0

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1

set ftp [new Application/FTP]
$ftp set type_ FTP
$ftp attach-agent $tcp1


$ns at 0.5 "$telnet start"
$ns at 0.6 "$ftp start"
$ns at 10.5 "$telnet stop"
$ns at 10.6 "$ftp stop"
$ns at 11.0 "finish"
$ns run

