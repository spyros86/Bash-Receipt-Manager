#!/bin/bash

#Spyridwn Vlachos
#Askhsh 2 Syspro 2011


#synarthseis pou ylopoiountai me awk.
#se ksexwristo fakelo gia eukolia anagnwshs.


function AFM_fixer
{
	sed -e 's/\([0-9]\{3\}\)\([0-9]\{3\}\)\([0-9]\{3\}\)/\1-\2-\3/' $1
}

function week_group
{
	awk '
	BEGIN { 
	}
	{
		if($1!="~ ~ ~")
		{
			sum[$3]+=$5;
			afm[$3]=$2;
			typ[$3]=$4;
			tot+=$5;
		}
	
	}
	END {
		for (x in sum )
			printf("%s %s %s %7.2f\n",x,afm[x],typ[x],sum[x]);
		printf("~ ~ ~ You have spent %7.2f\n",tot);
		
	}
	
	' $1 | AFM_fixer | sort -k +1 
}


function fix_week_ordered
{
	awk '
	BEGIN { 
	}
	{		
		if(NR==1) #an einai sthn prwth grammh pou exei to problhma me to total
		{
		sum=$0; #apothikeuse th
		next; #diabase thn epomenh
		}
		print $0; #typwnne
		
	
	}
	END {
	print sum; #typwse thn apothikeumenh
		
	}
	
	' $1 
}



function week_ordered
{
	awk '
	BEGIN { 
	}
	{		
		print $0;
		sum+=$5;
	
	}
	END {
		printf("~ ~ ~ You have spent %7.2f\n",sum);
	}
	
	' $1 | AFM_fixer | sort -n +0 -1 | fix_week_ordered
}

function week_type
{
	awk '
	BEGIN { 
	}
	{
		if($1!="~ ~ ~")
		{
			sum[$4]+=$5;
			tot+=$5;
		}
	
	}
	END {
		for (x in sum )
			printf("%s %7.2f\n",x,sum[x]);
		printf("~ ~ ~ You have spent %7.2f\n",tot);
	}
	
	' $1 | AFM_fixer | sort 
}

function fix_month
{
	awk '
	BEGIN { 
	}
	{		
		if($1=="~") #an einai sthn grammh pou exei to problhma me to total
		{
		
		next; #diabase thn epomenh
		}
		
		print $0; #typwnne
		
	
	}
	END {
		
		
	}
	
	' $1 
}


function month_type
{
	
	 awk '
	BEGIN { 
	}
	{
		if($1!="~ ~ ~")
		{
			sum[$1]+=$2;
			tot+=$2;
		}
	
	}
	END {
		for (x in sum )
			printf("%s %7.2f\n",x,sum[x]);
		printf("~ ~ ~ You have spent %7.2f\n",tot);
	}
	
	' $1 | sort 
}

function month_group
{
	awk '
	BEGIN { 
	}
	{
		if($1!="~ ~ ~")
		{
			sum[$1]+=$4;
			afm[$1]=$2;
			typ[$1]=$3;
			tot+=$4;
		}
	
	}
	END {
		for (x in sum )
			printf("%s %s %s %7.2f\n",x,afm[x],typ[x],sum[x]);
		printf("~ ~ ~ You have spent %7.2f\n",tot);
		
	}
	
	' $1 | sort 
}

function month_ordered
{
	sort -n +0 -1 $1 | awk '
	BEGIN { 
	}
	{		
		print $0;
		sum+=$5;
	
	}
	END {
		printf("~ ~ ~ You have spent %7.2f\n",sum);
	}
	
	' 
}



