#include <stdio.h>
#include <stdlib.h>
#define MAX 5
void insert_by_priority(int);
void delete_by_priority();
void display_pqueue();
 
int high[MAX];
int front1=-1, rear1=-1;

void check(int data)
{
    int i,j;
 
    for (i = 0; i <= rear1; i++)
    {
        if (data >= high[i])
        {
            for (j = rear1 + 1; j > i; j--)
            {
                high[j] = high[j - 1];
            }
            high[i] = data;
            return;
        }
    }
    high[i] = data;
}
 
void main()
{
    int n, ch,p;
 
    printf("\n1 - Insert a process");
    printf("\n2 - Process the high priority in the queue and display pending queue");
    printf("\n3 - Display pending queue");
    printf("\n4 - Exit");
 
   
 
    while (1)
    {
        printf("\nEnter your choice : ");    
        scanf("%d", &ch);
 
        switch (ch)
        {
        case 1: 
		         printf("\nEnter packet number");
		         scanf("%d",&n);
		         insert_by_priority(n);
		         break;
        case 2:
				  printf("Pending queue -\n");
				  display_pqueue();
				  delete_by_priority();
				  printf("Pending queue after processing-\n");
				  display_pqueue();
              break;
        case 3:
					printf("Pending queue -");
					display_pqueue();
               break;
        case 4: 
          		exit(0);
        default: 
            	printf("\nChoice is incorrect, Enter a correct choice");
        }
    }
}
 
 
/* Function to insert value into priority queue */
void insert_by_priority(int data)
{


    if (rear1 >= MAX - 1)
    {
        printf("\nQueue overflow no more elements can be inserted");
        
    }
    if ((front1 == -1) && (rear1 == -1))
    {
        front1++;
        rear1++;
        high[rear1] = data;
        
    }    
    else
        check(data);
    rear1++;

    

}
 
 
/* Function to delete an element from queue */
void delete_by_priority()
{
    int i=0;
 
    if ((front1==-1) && (rear1==-1))
    {
        printf("\nQueue is empty no elements to delete");
        return;
    }
 
    int data=high[0];
    printf(" High priority recently processed - %d\n",data);
       
            for (; i < rear1; i++)
            {
                high[i] = high[i + 1];
            }
 
        high[i] = -99;
        rear1--;
 
        if (rear1 == -1) 
            front1 = -1;
        return;
        
}
 
/* Function to display queue elements */
void display_pqueue()
{
    if ((front1 == -1) && (rear1 == -1))
    {
        printf("\nQueue is empty");
        return;
    }
 
    for (; front1 < rear1; front1++)
    {
        printf(" %d ",high[front1]);
    }
 
    front1 = 0;
}




