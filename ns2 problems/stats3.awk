BEGIN{
		tcpsent = 0;
		udpsent=0;
		tcpdrop = 0;
		udpdrop = 0;
		tcprecieved = 0;
		udprecieved = 0;
		totaldrop = 0;
		totalsent = 0;
		totalrecieved = 0;
}
{
		pkttype = $5;
		event = $1;
		if(pkttype == "tcp")
		{
			if(event == "d")
			tcpdrop++;
			else if(event == "+")
			tcpsent++;
			else if(event == "r")
			tcprecieved++;
		}
		if(pkttype == "cbr")
		{
			if(event == "d")
			udpdrop++;
			else if(event == "+")
			udpsent++;
			else if(event == "r")
			udprecieved;s
		}
}
END{
totalrecieved = tcprecieved + udprecieved;
totaldrop = tcpdrop + udpdrop;
totalsent = tcpsent + udpsent;
printf("TCP -->  Dropped: %d  Sent: %d  Recieved: %d\n",tcpdrop,tcpsent,tcprecieved);
printf("UDP -->  Dropped: %d  Sent: %d  Recieved: %d\n",udpdrop,udpsent,udprecieved);
printf("Total Dropped: %d\n",totaldrop);
printf("Total Sent: %d\n",totalsent);
printf("Total Recieved: %d\n",totalrecieved);
}
