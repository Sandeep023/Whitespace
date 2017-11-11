%option noyywrap

space [ ]
tab [\t]
lf [\n]
number [ ]|[\t]
sign [ ]|[\t]
charec [A-Z]|[a-z]|[0-9]
end [$]

%{
	#include<stdio.h>
	#include<string.h>
	FILE* output_open;
	int stack[10000];
	int top_index = 0;
	void seperate_text(char* str, int c);
	void push_into_stack(char* str);
	void duplecate_top_stack();
	void swap_top_two_stack();
	void discard_top_stack();
	//void stack_manipulations(int c);
	void input_output_function(int c);
	void arthematic(int arth);
	void flow_control_function(int flow_control, char* str);

%}

%%

{charec}*{space}{charec}*{space}{charec}*{sign}{number}+{charec}*	seperate_text(yytext, 1);
{charec}*{space}{charec}*{lf}{charec}*{space}{charec}*	seperate_text(yytext, 2);
{charec}*{space}{charec}*{lf}{charec}*{tab}{charec}*	seperate_text(yytext, 3);
{charec}*{space}{charec}*{lf}{charec}*{lf}{charec}*	seperate_text(yytext, 4);

{charec}*{tab}{charec}*{lf}{charec}*{space}|{tab}{charec}*{space}|{tab}{charec}*	seperate_text(yytext, 5);

{charec}*{tab}{charec}*{space}{charec}*{space}|{tab}{charec}*{space}|{tab}|{lf}{charec}*	seperate_text(yytext, 6);

{charec}*{lf}{charec}*{space}|{tab}{charec}*{space}|{tab}|{lf}{charec}*	seperate_text(yytext, 7);

%%


void seperate_text(char* str, int c){
	int length = strlen(str);
	char *string = (char *) malloc(sizeof(char) * 3);
	int j=0;
	int i;
	for(i=0; i<length; i++){
		if (str[i] == ' '){
			string[j] = str[i];
			j++;
		}
		else if(str[i] == '\t'){
			string[j] = str[i];
			j++;
		}
		else if(str[i] == '\n'){
			string[j] = str[i];
			j++;
		}
	}

	int arth = 0, input_output = 0, stack_manipulation = 0, flow_control = 0;;

	if(c == 5){
		if(string[strlen(string)-1] == ' ')
			input_output = input_output + 0;
		else if(string[strlen(string)-1] == '\t')
			input_output = input_output + 1;

		if(string[strlen(string)] == ' ')
			input_output = (input_output*2) + 0;
		else if(string[strlen(string)] == '\t')
			input_output = (input_output*2) + 1;
	}

	else if(c == 6){
		if(string[strlen(string)-1] == ' ')
			arth = arth + 0;
		else if(string[strlen(string)-1] == '\t')
			arth = arth + 1;

		if(string[strlen(string)] == ' ')
			arth = (arth*3) + 0;
		else if(string[strlen(string)] == '\t')
			arth = (arth*3) + 1;
		else if(string[strlen(string)] == '\n')
			arth = (arth*3) + 2;
	}

	else if(c == 7){
		if(string[1] == ' ')
			flow_control = flow_control + 0;
		else if(string[1] == '\t')
			flow_control = flow_control + 1;

		if(string[2] == ' ')
			flow_control = (flow_control*3) + 0;
		else if(string[2] == '\t')
			flow_control = (flow_control*3) + 1;
		else if(string[2] == '\n')
			flow_control = (flow_control*3) + 2;
	}

	switch(c){
		case(1):
			push_into_stack(string);
			break;
		case(2):
			duplecate_top_stack();
			break;
		case(3):
			swap_top_two_stack();
			break;
		case(4):
			discard_top_stack();
			break;
		case(5):
			input_output_function(input_output);
			break;
		case(6):
			arthematic(arth);
			break;
		case(7):
			flow_control_function(c, string);
			break;
	}
}

void flow_control_function(int c, char* str){
	if(c == 1){

	}
	else if(arth == 1){

	}
	else if(arth == 2){

	}
	else if(arth == 3){

	}
	else if(arth == 4){

	}
	else if(arth == 5){

	}
}

void arthematic(int arth){
	int top = stack[top_index - 1];
	int second = stack[top_index - 2];
	int result;
	if(arth == 0){
		result = second + top;
	}
	else if(arth == 1){
		result = second - top;
	}
	else if(arth == 2){
		result = second * top;
	}
	else if(arth == 3){
		result = second / top;
	}
	else if(arth == 4){
		result = second % top;
	}
	printf("%d ", result);
}

void input_output_function(int c){
	if(c == 0){
		printf("%c ", stack[top_index]);
	}
	else if(c == 1){
		printf("%d ", stack[top_index]);
	}
	else if(c == 2){
		char ch;
		scanf("%c", &ch);
		stack[top_index] = ch;
		top_index++;
	}
	else if(c == 3){
		int d;
		scanf("%d", &d);
		stack[top_index] = d;
		top_index++;
	}
}


void discard_top_stack(){
	if (top_index == 0)
		top_index = top_index;
	else{
		top_index--;
	}
}

void duplecate_top_stack(){
	stack[top_index] = stack[top_index - 1];
	top_index++;
}

void swap_top_two_stack(){
	int temp = stack[top_index - 1];
	stack[top_index - 1] = stack[top_index - 2];
	stack[top_index - 2] = temp;
}

void push_into_stack(char* str){
	int num = 0, i;
	for(i=3; i<strlen(str); i++){
		if(str[i] == ' '){
			num = (num * 2) + 0;
		}
		else if(str[i] == '\t'){
			num = (num * 2) + 1;
		}
	}
	if(str[2] == ' '){
		stack[top_index] = num;
		top_index++;
	}
	else if(str[2] == '\t'){
		stack[top_index] = 0 - num;
		top_index++;
	}
}

int main(int argc, char* argv[]){
	output_open = fopen("Output.txt", "w");
	yyin = fopen("program.txt", "r");
	yylex();
	return 0;
}