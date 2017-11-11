%{
void yyerror (char *s);
#include "y.tab.h"
#include "lex.yy.h"
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <string.h>

int stack[100000];
int top_index = 0;
char commands[1000][1000];
int cmd_num = 0;
int stack_operations(int c, int operation);
void arthematic(int c);
void input_output(int c);
void print_all_commands();
%}

%union {char cmd;}
%start C
%token <cmd> command
%token <ex> exit_command
%token <cmd> space
%token <cmd> tab
%token <cmd> linefeed
%token <cmd> end_cmd
%token <cmd> start_cmd
%type <cmd> number C

%%

C 	:	C space space tab number 		{stack_operations($5, 0);/*printf("%d", $5);push to stack*/}
	|	C space space space number		{stack_operations(0 - $5, 0);/*printf("%d", $5);push to stack*/}
	|	C space linefeed space			{stack_operations(0, 1);/*printf("dup top");duplicate top element*/}
	|	C space linefeed tab 			{stack_operations(0, 2);/*printf("Swap");swap top two*/}
	|	C space linefeed linefeed		{int top = stack_operations(0, 3);printf("top %d", top);/*top*/}
	|	C space tab space number		{stack_operations($5, 4);/*printf("Copy nth");copy nth element to pop*/}
<<<<<<< HEAD
	|	C space tab tab number 			{stack_operations($5, 5);/*printf("Print in stright");Print in stright*/}
	|	C space tab linefeed number		{stack_operations($5, 6);/*printf("Print in reverse\n");Print in stright*/}
	|	C tab space number				{arthematic($4);/*printf("arthematic %d", $4);*/}
	|	C tab linefeed number			{/*printf("input");*/input_output($4);} 
=======
	|	C space tab tab number			{stack_operations($5, 5);/*printf("Print in stright");Print in stright*/}
	|	C space tab linefeed number		{stack_operations($5, 6);/*printf("Print in reverse\n");Print in stright*/}
	|	C tab space number				{arthematic($4);/*printf("arthematic %d", $4);*/}
	|	C tab linefeed number			{/*printf("input");*/input_output($4);}
>>>>>>> 3547f939826af7281bdc24c48461804a5f620cba
	|	C exit_command					{/*print_all_commands();*/exit(EXIT_SUCCESS);}
	|	C space							{}
	|	C tab 							{}
	|	C linefeed 						{}
	|	C tab tab tab tab tab			{}
	|									{/*printf("Null prodection");*/}
	;


number 	:	number tab 					{$$ = ($1*2) + 1;}
		|	number space				{$$ = ($1*2) + 0;}
		|	tab 						{$$ = 1;}
		|	space						{$$ = 0;}
		;


%%

void print_all_commands(){
	int i;
	for(i=0; i<cmd_num; i++){
		printf("%s\n", commands[i]);
	}
}

void input_output(int c){
	//printf("inout: %d\n", c);
	if( c == 0 ){
		//commands[cmd_num] = "print Char";
		strncpy(commands[cmd_num], "print Char", sizeof(commands[cmd_num]));
		cmd_num++;
		printf("%c\n", stack[top_index - 1]);
	}
	else if( c == 1 ){
		//commands[cmd_num] = "print Int";
		strncpy(commands[cmd_num], "print Int", sizeof(commands[cmd_num]));
		cmd_num++;
		printf("%d\n", stack[top_index - 1]);
	}
	else if( c == 2 ){
		//commands[cmd_num] = "input Char";
		strncpy(commands[cmd_num], "input Char", sizeof(commands[cmd_num]));
		cmd_num++;
		char ch;
		printf("Enter a Charector\n");
		scanf("%c", &ch);
		stack_operations(ch, 0);
	}
	else if( c == 3 ){
		//commands[cmd_num] = "input Int";
		strncpy(commands[cmd_num], "input Int", sizeof(commands[cmd_num]));
		cmd_num++;
		int ch;
		printf("Enter an integer\n");
		scanf("%d", &ch);
		stack_operations(ch, 0);
	}
}

void arthematic(int c){
	int top = stack_operations(0, 3);
	int next = stack_operations(0, 3);
	int result = -1;
	//printf("%d\n", c);
	if(c == 0){
		//commands[cmd_num] = "Addition";
		strncpy(commands[cmd_num], "Addition", sizeof(commands[cmd_num]));
		cmd_num++;
		result = next + top;
	}
	else if(c == 1){
		//commands[cmd_num] = "Subtraction";
		strncpy(commands[cmd_num], "Subtraction", sizeof(commands[cmd_num]));
		cmd_num++;
		result = next - top;
	}
	else if(c == 2){
		//commands[cmd_num] = "Multiplication";
		strncpy(commands[cmd_num], "Multiplication", sizeof(commands[cmd_num]));
		cmd_num++;
		result = next * top;
	}
	else if(c == 3){
		//commands[cmd_num] = "Division";
		strncpy(commands[cmd_num], "Division", sizeof(commands[cmd_num]));
		cmd_num++;
		result = next / top;
	}
	else if(c == 4){
		//commands[cmd_num] = "Modulous";
		strncpy(commands[cmd_num], "Modulos", sizeof(commands[cmd_num]));
		cmd_num++;
		result = next % top;
	}
	stack_operations(result, 0);
	printf("Result : %d\n", result);
}

int stack_operations(int c, int operation){
	if(operation == 0){
		//commands[cmd_num] = "Push";
		strncpy(commands[cmd_num], "Push", sizeof(commands[cmd_num]));
		cmd_num++;
		stack[top_index] = c;
		top_index++;
		return -1;
	}
	else if(operation == 1){
		//commands[cmd_num] = "Duplicate Top";
		strncpy(commands[cmd_num], "Du[licate Top", sizeof(commands[cmd_num]));
		cmd_num++;
		stack[top_index] = stack[top_index - 1];
		top_index++;
		return -1;
	}
	else if(operation == 2){
		//commands[cmd_num] = "Swap Top two";
		strncpy(commands[cmd_num], "Swap Top two", sizeof(commands[cmd_num]));
		cmd_num++;
		int temp = stack[top_index - 1];
		stack[top_index - 1] = stack[top_index - 2];
		stack[top_index - 2] = temp;
		return -1;
	}
	else if(operation == 3){
		//commands[cmd_num] = "Pop";
		strncpy(commands[cmd_num], "Pop", sizeof(commands[cmd_num]));
		cmd_num++;
		if(top_index == 0){
			return -1;
		}
		else{
			top_index--;
			//printf("%d\n", stack[top_index]);
			return stack[top_index];
		}
	}
	else if(operation == 4){
		//commands[cmd_num] = "Copy nth element";
		strncpy(commands[cmd_num], "Copyt nth element", sizeof(commands[cmd_num]));
		cmd_num++;
		if(top_index < c){
			printf("Error: There aren't enough elements in the stack");
		}
		else{
			stack[top_index - c] = stack[top_index];
			top_index++;
		}
		return 0;
	}
	else if(operation == 5){
		//commands[cmd_num] = "Print stack in order";
		strncpy(commands[cmd_num], "Print stack in order", sizeof(commands[cmd_num]));
		cmd_num++;
		int i;
		if(c == 0){
			for(i=top_index-1; i>=0; i--){
				printf("%d ", stack[i]);
			}
		}
		if(c == 1){
			for(i=top_index-1; i>=0; i--){
				printf("%c", stack[i]);
			}
		}
		printf("\n");
	}
	else if(operation == 6){
		//commands[cmd_num] = "Print stack in reverse";
		strncpy(commands[cmd_num], "Print stack in reverse", sizeof(commands[cmd_num]));
		cmd_num++;
		int i;
		if( c == 0 ){
			for(i=0; i<top_index; i++){
				printf("%d ", stack[i]);
			}
		}
		if( c == 1 ){
			for(i=0; i<top_index; i++){
				printf("%c", stack[i]);
			}
		}
		printf("\n");
	}
}

int main (void) {
	/* init symbol table */
<<<<<<< HEAD
	//yyin = fopen("arthemtic.ws", "r");
	//yyin = fopen("helloworld.ws", "r");
	yyin = fopen("basic.ws", "r");
=======
	yyin = fopen("addition.ws", "r");
>>>>>>> 3547f939826af7281bdc24c48461804a5f620cba
	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

