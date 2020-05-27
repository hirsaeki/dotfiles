# setfacl
# Autogenerated from man page /usr/share/man/man1/setfacl.1.gz
complete -c setfacl -s b -l remove-all --description 'Remove all extended ACL entries.'
complete -c setfacl -s k -l remove-default --description 'Remove the Default ACL.  If no Default ACL exists, no warnings are issued.'
complete -c setfacl -s n -l no-mask --description 'Do not recalculate the effective rights mask.'
complete -c setfacl -l mask --description 'Do recalculate the effective rights mask, even if an ACL mask entry was expli…'
complete -c setfacl -s d -l default --description 'All operations apply to the Default ACL.'
complete -c setfacl -l restore --description 'Restore a permission backup created by `getfacl -R\' or similar.'
complete -c setfacl -l test --description 'Test mode.'
complete -c setfacl -s R -l recursive --description 'Apply operations to all files and directories recursively.'
complete -c setfacl -s L -l logical --description 'Logical walk, follow symbolic links to directories.'
complete -c setfacl -s P -l physical --description 'Physical walk, do not follow symbolic links to directories.'
complete -c setfacl -s v -l version --description 'Print the version of setfacl and exit.'
complete -c setfacl -s h -l help --description 'Print help explaining the command line options.'
complete -c setfacl -s m --description 'and.'
complete -c setfacl -s x --description 'expect an ACL on the command line.'
complete -c setfacl -s M --description 'and.'
complete -c setfacl -s X --description 'read an ACL from a file or from standard input.'
complete -c setfacl -l set -l set-file --description 'options set the ACL of a file or a directory.  The previous ACL is replaced.'
complete -c setfacl -l modify -l modify-file --description 'options modify the ACL of a file or directory.'
complete -c setfacl -l remove -l remove-file --description 'options remove ACL entries.'

