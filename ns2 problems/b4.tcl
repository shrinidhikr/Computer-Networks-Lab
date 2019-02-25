set ns [new Simulator]

set tracefile [open 4.tr w]
$ns trace-all $tracefile

set namfile [open 4.nam w]
$ns namtrace-all $namfile

proc finish {} {
		global ns tracefile namfile
		$ns flush-trace
		close $tracefile
		close $namfile
		
		exec awk -f stats4.awk 4.tr &
		exec nam 4.nam &
		exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

$ns duplex-link $n1 $n0 1Mb 10ms DropTail
$ns duplex-link $n2 $n0 1Mb 10ms DropTail
$ns duplex-link $n3 $n0 1Mb 10ms DropTail
$ns duplex-link $n4 $n0 1Mb 100ms DropTail
$ns duplex-link $n5 $n0 1Mb 100ms DropTail
$ns duplex-link $n6 $n0 1Mb 90ms DropTail

Agent/Ping instproc recv {from rtt} {
		$self instvar node_
		puts "node [$node_ id] recieved ping answer from $from with round-trip-time $rtt ms."  
}

set pingAgent1 [new Agent/Ping]
$ns attach-agent $n1 $pingAgent1
set pingAgent2 [new Agent/Ping]
$ns attach-agent $n2 $pingAgent2
set pingAgent3 [new Agent/Ping]
$ns attach-agent $n3 $pingAgent3
set pingAgent4 [new Agent/Ping]
$ns attach-agent $n4 $pingAgent4
set pingAgent5 [new Agent/Ping]
$ns attach-agent $n5 $pingAgent5
set pingAgent6 [new Agent/Ping]
$ns attach-agent $n6 $pingAgent6

$ns queue-limit $n0 $n1 2
$ns queue-limit $n0 $n2 2
$ns queue-limit $n0 $n3 2
$ns queue-limit $n0 $n4 2
$ns queue-limit $n0 $n5 2
$ns queue-limit $n0 $n6 1

$ns connect $pingAgent1 $pingAgent4
$ns connect $pingAgent2 $pingAgent5
$ns connect $pingAgent3 $pingAgent6

$ns at 0.1 "$pingAgent1 send"
$ns at 0.5 "$pingAgent2 send"
$ns at 0.5 "$pingAgent3 send"
$ns at 0.5 "$pingAgent4 send"
$ns at 1.0 "$pingAgent5 send"
$ns at 1.0 "$pingAgent6 send"
$ns at 1.1 "$pingAgent1 send"
$ns at 1.5 "$pingAgent2 send"
$ns at 1.5 "$pingAgent3 send"
$ns at 1.5 "$pingAgent4 send"
$ns at 2.0 "$pingAgent5 send"
$ns at 2.0 "$pingAgent6 send"
$ns at 3.0 "finish"
$ns run
