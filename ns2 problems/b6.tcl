set ns [new Simulator]

set error_rate 0.00

set tracefile [open 6.tr w]
$ns trace-all $tracefile

set namfile [open 6.nam w]
$ns namtrace-all $namfile

proc finish {} {
			global ns namfile tracefile
			$ns flush-trace
			close $tracefile
			close $namfile
			exec awk -f stats6.awk 6.tr &
			exec nam 6.nam &
			exit 0			
}

for {set i 0} {$i < 6} {incr i} {
		set n($i) [$ns node]
}

$ns color 1 blue
$ns color 2 red

$ns duplex-link $n(0) $n(2) 2Mb 10ms DropTail
$ns duplex-link $n(1) $n(2) 2Mb 10ms DropTail
$ns duplex-link $n(2) $n(3) 0.3Mb 100ms DropTail

set lan [$ns newLan "$n(3) $n(4) $n(5)" 0.5Mb 40ms LL Queue/DropTail MAC/802_3 Channel]

$ns duplex-link-op $n(0) $n(2) orient right-down
$ns duplex-link-op $n(1) $n(2) orient right-up
$ns duplex-link-op $n(2) $n(3) orient right

$ns queue-limit $n(2) $n(3) 20
#$ns duplex-link-op $n(2) $n(3) queuePos 0.5

set loss_module [new ErrorModel]
$loss_module ranvar [new RandomVariable/Uniform]
$loss_module drop-target [new Agent/Null]
$loss_module set rate_ $error_rate
$ns lossmodel $loss_module $n(2) $n(3)

set tcp [new Agent/TCP]
$ns attach-agent $n(0) $tcp
$tcp set fid_ 1
$tcp set window_ 8000
$tcp set packetSize_ 552

set sink [new Agent/TCPSink]
$ns attach-agent $n(4) $sink
$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp set type_ FTP
$ftp attach-agent $tcp

set udp [new Agent/UDP]
$ns attach-agent $n(1) $udp
$udp set fid_ 2

set null [new Agent/Null]
$ns attach-agent $n(5) $null
$ns connect $udp $null

set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 1000
$cbr set random_ false
$cbr set type_ CBR
$cbr set rate_ 0.2Mb
$cbr attach-agent $udp


$ns at 0.1 "$ftp start"
$ns at 1.0 "$cbr start"
$ns at 124.0 "$ftp stop"
$ns at 124.5 "$cbr stop"
$ns at 125.0 "finish"
$ns run
