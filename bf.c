#include<stdio.h>
int i,j,n,visited[20],source,cost[20][20],d[20];

int min(int i,int j)
{
	if(i>j)
		return(j);
	return(i);
}

void bf()
{
int k;
for(i=1;i<=n;i++)
{
	if(i!=source)
		d[i]=999;
	else d[i]=0;
}

for(k=1;k<=n;k++)
{
	for(i=1;i<=n;i++){
		for(j=1;j<=n;j++){
			d[j]=min(d[j],d[i]+cost[i][j]);	
	   }
	}
}

}

void main()
{
int p = 0;
printf("Enter no of vertices: ");
scanf("%d",&n);

printf("Enter the cost adjacency matrix\n");
for(i=1;i<=n;i++)
{
 for(j=1;j<=n;j++)
 {
  scanf("%d",&cost[i][j]);
 }
}

for (p=1;p<=n;p++){

printf("\nFor router %d",p);
/*scanf("%d",&source);*/

source = p;
bf();
for(i=1;i<=n;i++)
 //if(i!=source)
  printf("\nShortest path from %d to %d is %d",source,i,d[i]);
printf("\n");
}
}
