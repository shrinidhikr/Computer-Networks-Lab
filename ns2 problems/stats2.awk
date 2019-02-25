BEGIN{
	telpkt = 0;
	ftppkt = 0;
	telsize = 0;
	ftpsize = 0;
	totaltel = 0;
	totalftp = 0;
}
{
		event=$1;
		pkttype=$5;
		fromnode=$9;
		tonode=$10;
		pktsize=$6;
		
		if(event =="r" && pkttype== "tcp" && fromnode == "0.0" && tonode=="3.0")
		{
				telpkt++;
				telsize=pktsize;
		}
		if(event =="r" && pkttype== "tcp" && fromnode == "1.0" && tonode=="3.1")
		{
				ftppkt++;
				ftpsize=pktsize;
		}
		
}
END{
		totaltel = telpkt*telsize*8;
		totalftp = ftppkt*ftpsize*8;
		printf("Throughput of FTP application is %d \n",totalftp/10);
		printf("Throughout of TELNET application is %d \n",totaltel/10);
}
