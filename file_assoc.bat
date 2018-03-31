
ftype txtfile=emacsclientw -na runemacs "%1"
ftype EmacsLisp=emacsclientw -na runemacs "%1"
ftype CodeFile=emacsclientw -na runemacs "%1"
assoc .txt=txtfile
assoc .text=txtfile
assoc .log=txtfile
assoc .org=txtfile
assoc .el=EmacsLisp
assoc .c=CodeFile
assoc .h=CodeFile
