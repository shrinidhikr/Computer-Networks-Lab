#include<stdio.h>
#include<unistd.h>
#include<fcntl.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<stdlib.h>
#include<string.h>

int main()

{

  int cs,ns,fd,n;
  int bufsize=1024;
  char *buffer=malloc(bufsize);
  struct sockaddr_in address;
  char fname[255];
  address.sin_family=AF_INET;
  address.sin_port=htons(15000);
  address.sin_addr.s_addr=INADDR_ANY;
  cs=socket(AF_INET,SOCK_STREAM,0);
  bind(cs,(struct sockaddr *)&address,sizeof(address));
  listen(cs,3);
  ns=accept(cs,(struct sockaddr *)NULL,NULL);
  recv(ns,fname,255,0);
  fd=open(fname,O_RDONLY);
  if(fd==-1){
    strcpy(buffer,"No file found!");
    n = strlen(buffer);    
  }
  else{
    n=read(fd,buffer,bufsize);
  }
  send(ns,buffer,n,0);
  close(ns);
  return close(cs);

}
