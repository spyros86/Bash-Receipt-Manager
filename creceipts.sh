#!/bin/bash

#Spyridwn Vlachos 
#Askhsh 2 Syspro 2011


source functions.sh #file me functions pou prepei na einai eite sto PATH eite sto idio directory me to paron arxeio. Edw to deutero isxyei.
echo "Creceipts Start!"
echo "Usage: creceipts -p /{receipt directory} -r 1stMonth LastMonth input# $#"
echo ""

Ms=(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec) #0 ews 11
MchOrder=(0 0 0 0 0 0 0 0 0 0 0 0) #gia to an exei allaksei o mhnas ara tha prepei na graftei sto xrono.
MchGroup=(0 0 0 0 0 0 0 0 0 0 0 0)
MchType=(0 0 0 0 0 0 0 0 0 0 0 0)
apotelesma="Receipts2010"
fixyrType=0
fixyrGroup=0
fixyrOrder=0

#elegxw ta orismata
for arg
	do
		#echo "To arguement exei timh: ${arg}"

		if [ "$1" = "-p" ] #an einai -p to directory einai sto 2
			then		
				recdir=$2
				shift 2
		elif [ "$1" = "-r" ] #an einai -r sto 2 kai 3 exw tous mhnes
			then
				firstM=$2
				lastM=$3
				with_r=1 #eixa -r
		else
			echo "Usage: creceipts -p /{receipt directory} -r 1stMonth LastMonth"
		fi	
	done
	
if ((!with_r))
	then
		firstM=Jan
		lastM=Dec
fi
	


#echo "recdir: $recdir"
#echo "firstM: $firstM"
#echo "lastM: $lastM"
	
#pairnw tous arithmous twn mhnwn
for (( i=0; i<12; i++))			
	do
		if [ ${Ms[i]} = "$firstM" ]
			then
				#echo $i #echo ${Ms[i]}
				firstM=$i
		fi
		if [ ${Ms[i]} = "$lastM" ]
			then
				#echo $i #echo ${Ms[i]}
				lastM=$i
		fi
	done
	
#echo "firstM: $firstM"
#echo "lastM: $lastM"

cd $recdir #mpainw sto directory pou dothike.

for (( i=firstM; i<=lastM; i++)) 
	do #gia kathe mhna
	{	#echo $i
		
		cd ${Ms[i]} #mpainw sto mhna
		
			
		#pwd
		for (( w=1; w<=4; w++)) 
		do #gia kathe ebdomada
		{
			#echo week$w.type
			if [ ! -e week$w.type ] #an den yparxoun hdh ypologise ta
				then
				{
					week_type week$w > week$w.type
					#text gia mail
					cat week$w.type | fix_month >> ${Ms[i]}.type
					#afou allakse o mhnas to shmeiwnw gia na ton balw sto etos
					MchType[i]=1
					
					echo "Added file week$w.type in `pwd`/" >> ${recdir}/mail.txt
				}
			fi
			if [ ! -e week$w.group ] #an den yparxoun hdh ypologise ta
				then
				{
				
					week_group week$w > week$w.group
					#text gia mail
					cat  week$w.group | fix_month >> ${Ms[i]}.group
					MchGroup[i]=1
					echo "Added file week$w.group in `pwd`/" >> ${recdir}/mail.txt
				}
			fi
			if [ ! -e week$w.ordered ] #an den yparxoun hdh ypologise ta
				then
				{
					
					week_ordered week$w > week$w.ordered #to bazw sto ordered ths ebdomadas.
					#text gia mail
					cat  week$w.ordered | fix_month >> ${Ms[i]}.ordered
					MchOrder[i]=1
					echo "Added file week$w.ordered in `pwd`/" >> ${recdir}/mail.txt
				}
			fi
						
			#pwd
		}
		done
		
		curdir=`pwd` #krataw to dir
		#koitaw an exei allaksei kapoios mhnas ton ftiaxnw afou prwta ton kanw append sto xrono
		if [ "${MchType[i]}" -eq 1 ]
			then
			{
				cat ${Ms[i]}.type >> ../$apotelesma.type #arxeio etous
				month_type ${Ms[i]}.type > ${Ms[i]}.type.tmp
				cat ${Ms[i]}.type.tmp > ${Ms[i]}.type
				rm ${Ms[i]}.type.tmp
				fixyrType=1
				echo "Added file ${Ms[i]}.type in `pwd`/" >> ${recdir}/mail.txt
			}
		fi
		if [ "${MchGroup[i]}" -eq 1 ]
			then
			{
				cat  ${Ms[i]}.group >> ../$apotelesma.group
				month_group ${Ms[i]}.group > ${Ms[i]}.group.tmp
				cat ${Ms[i]}.group.tmp > ${Ms[i]}.group
				rm ${Ms[i]}.group.tmp
				fixyrGroup=1
				echo "Added file ${Ms[i]}.group in `pwd`/" >> ${recdir}/mail.txt
			}
		fi
		if [ "${MchOrder[i]}" -eq 1 ]
			then
			{
				cat ${Ms[i]}.ordered >> ../$apotelesma.ordered
				month_ordered ${Ms[i]}.ordered > ${Ms[i]}.ordered.tmp
				cat ${Ms[i]}.ordered.tmp > ${Ms[i]}.ordered
				rm ${Ms[i]}.ordered.tmp
				fixyrOrder=1
				echo "Added file ${Ms[i]}.ordered in `pwd`/" >> ${recdir}/mail.txt
			}
		fi
		
			
			
			
			
		
	
		cd .. #paw pisw gia na allaksw mhna
	}
	done
		#echo ${MchOrder[*]}
		#echo ${MchGroup[*]}
		#echo ${MchType[*]}
		
		
		
		
		
	
	#ftiaxnw ta arxeia tou xronou an exoun allaxtei ta antistoixa twn mhnwn
	cd $recdir
	
	if [ "$fixyrType" -eq 1 ] #prepei na kanw sort sum to xrono
		then
		{	
				
				month_type $apotelesma.type > $apotelesma.type.tmp
				cat $apotelesma.type.tmp > $apotelesma.type
				rm $apotelesma.type.tmp
				echo "Added file $apotelesma.type in `pwd`/" >> ${recdir}/mail.txt
				
		}
	fi
	if [ "$fixyrOrder" -eq 1 ] #prepei na kanw sort sum to xrono
		then
		{
				month_ordered $apotelesma.ordered > $apotelesma.ordered.tmp
				cat $apotelesma.ordered.tmp > $apotelesma.ordered
				rm $apotelesma.ordered.tmp
				echo "Added file $apotelesma.ordered in `pwd`/" >> ${recdir}/mail.txt
		}
	fi
	if [ "$fixyrGroup" -eq 1 ] #prepei na kanw sort sum to xrono
		then
		{
				month_group $apotelesma.group > $apotelesma.group.tmp
				cat $apotelesma.group.tmp > $apotelesma.group
				rm $apotelesma.group.tmp
				echo "Added file $apotelesma.group in `pwd`/" >> ${recdir}/mail.txt
		}
	fi
		
		

#to mail.txt einai etoimo menei na brw xrhsth kai na to steilw



if [ -e mail.txt ]
	then
	{
		cat mail.txt | mailx \-s "Test" `whoami`@di.uoa.gr
	}
fi












exit 0










		
		
	
