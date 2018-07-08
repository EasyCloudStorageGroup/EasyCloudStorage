function onChange() {
    //alert("dddd")
    var input=document.getElementById("uploader")
    var table=document.getElementById("table")
    tableClear(table)
    var length=input.files.length
    for (var i=0;i<length;++i){
        var row=table.insertRow(i+1)
        var cell1=row.insertCell(0)
        var cell2=row.insertCell(1)
        cell1.innerHTML=input.files[i].name
        cell2.innerHTML="等待传输"
    }
}
function tableClear(table) {
    var row=table.rows.length
    for (var i=row-1;i>0;--i) table.deleteRow(1)
}