set ns [new Simulator]

set tracefile [open 1.tr w]
$ns trace-all $tracefile

set namfile [open 1.nam w]
$ns namtrace-all $namfile

proc finish {} {
		global ns namfile tracefile
		$ns flush-trace
		
		close $tracefile
		close $namfile
		exec awk -f stats1.awk 1.tr &
		exec nam 1.nam &
		exit 0
}

set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n1 $n2 0.5Mb 20ms DropTail
$ns duplex-link $n2 $n3 0.5Mb 20ms DropTail
$ns queue-limit $n1 $n2 10
$ns queue-limit $n2 $n3 10

set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 512
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n3 $null0

$ns connect $udp0 $null0
$udp0 set fid_ 2

$ns at 0.5 "$cbr0 start"
$ns at 2.0 "$cbr0 stop"
$ns at 2.0 "finish"
$ns run






























