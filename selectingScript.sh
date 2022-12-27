#! /bin/bash
export LC_COLLATE=C
shopt -s extglob

function selectAll() {
    result=$(cat $1)
    whiptail --msgbox "$result" 20 78
}
####################################################selecting using colomun name

function col_num() {
    result=$(awk -F : -v value=$2 '{
     for (i=1; i<NF; i++){
        if($i == value && NR == 1){
            print(i)
        
        }
     }
    }' $1)
    echo $result
}

function selectColomun() {
    echo 'please enter coloumn name'
    read colName
    result=$(col_num $1 $colName)
    if [[ -z "$result" ]]; then
        echo "invaild coloumn name"
    else
        awk -F : -v value=$result '{
        if ( NR != 1)
        print($value)
        }' $1
    fi
}
######################################################################

####################################################selecting row using any table valid value
function selectRow() {
    echo "enter a value to print its row"
    read value
    count=0
    awk -F : -v value=$value '{
        for (i=1; i<NF; i++)
        {
            if($i == value && NR != 1){
                print($0)
                count++
                }
        }
        }END{
            if (count == 0){print ("Invalid value")}
        } ' $1
}
##########################################################################
