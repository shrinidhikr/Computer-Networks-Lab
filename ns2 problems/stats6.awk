BEGIN{
	totaltcp = 0;
	totaludp = 0;
	tcpsize = 0;
	udpsize = 0;
	tcppkt=0;
	udppkt=0;
}
{
		event = $1;
		pkttype = $5;
		pktsize = $6;
		
		if(event == "r" && pkttype == "tcp")
		{
			tcppkt++;
			tcpsize = pktsize;
		}
		if(event == "r" && pkttype == "cbr")
		{
			udppkt++;
			udpsize = pktsize;
		}
}
END{
	totaltcp = tcpsize * tcppkt * 8;
	totaludp = udpsize * udppkt * 8;
	printf("Throughput of TCP: %d\n",totaltcp/124);
	printf("Throughput of UDP: %d\n",totaludp/124);
}
