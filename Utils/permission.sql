BEGIN
    dbms_java.grant_permission(
        grantee =>           'SANKHYA',  
        permission_type =>   'SYS:java.lang.RuntimePermission',
        permission_name =>   'readFileDescriptor',
        permission_action => null
    );
    dbms_java.grant_permission(
        grantee =>           'SANKHYA', 
        permission_type =>   'SYS:java.lang.RuntimePermission',
        permission_name =>   'writeFileDescriptor',
        permission_action => null
    );
    dbms_java.grant_permission(
        grantee =>           'SANKHYA', 
        permission_type =>   'SYS:java.io.FilePermission',
        permission_name =>   '/bin/ls',
        permission_action => 'execute'
    );
    dbms_java.grant_permission(
        grantee =>           'SANKHYA',
        permission_type =>   'SYS:java.io.FilePermission',
        permission_name =>   '<<ALL FILES>>',
        permission_action => 'execute'
    );     
END;

grant execute on OS_COMMAND to TESTE; 
grant execute on "ExternalCall" to TESTE;
grant execute on java source "OS_HELPER" to TESTE;
grant execute on java source "FILE_TYPE_JAVA" to TESTE;
grant execute on "FileType" to TESTE;
grant execute on lob_writer_plsql to TESTE;
grant execute on FILE_PKG to TESTE;
grant execute on FILE_TYPE to TESTE;
grant execute on FILE_LIST_TYPE to TESTE;
grant execute on file_security to TESTE;    