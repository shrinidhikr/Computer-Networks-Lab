BEGIN{
		sent = 0;
		recieved = 0;
		lost = 0;
		#dq = 0;
		#k=0; 
}
{
		pkttype = $5;
		event = $1;
		
		if(pkttype == "cbr")
		{
				if(event == "+")
				{
					sent++;
				}
				else if(event == "r")
				{
					recieved++;
				}
				else if(event == "d")
				{
					lost++;
				}
				#else if(event == "-")
				#{
				#	dq++;
				#}
				#else
				#k++;
		}
		
}
END{
printf("Total recieved: %d\n",recieved);
printf("Total dropped: %d\n",lost);
printf("Total sent: %d\n",sent);
#printf("Total dequeue: %d\n",dq);
#printf("Total other: %d\n",k);
}
