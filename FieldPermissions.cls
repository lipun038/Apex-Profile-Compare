//For Field Permission
        string csvString = 'Object Name,Field Name,Permission Name,Sales 4.0,Sales Agent SDR w Insidesales';
        Set<string> fieldSet = new Set<string>();
        Map<string,FieldPermissions> obMap1 = new Map<string,FieldPermissions>();
        Map<string,FieldPermissions> obMap2 = new Map<string,FieldPermissions>();
        for(FieldPermissions ob1 : [SELECT Field, PermissionsRead,PermissionsEdit,Parent.Profile.Name FROM FieldPermissions WHERE Parent.Profile.Name = 'Sales 4.0' Order By SObjectType]){
            obMap1.put(ob1.Field,ob1);
            fieldSet.add(ob1.Field);    
        }
        for(FieldPermissions ob2 : [SELECT Field, PermissionsRead, PermissionsEdit, Parent.Profile.Name FROM FieldPermissions WHERE Parent.Profile.Name = 'Sales Agent SDR w Insidesales' Order By SObjectType]){
            obMap2.put(ob2.Field,ob2); 
            fieldSet.add(ob2.Field); 
        }
        
        for(string Field : fieldSet){
            FieldPermissions ob1 = obMap1.get(Field);
            FieldPermissions ob2 = obMap2.get(Field);
            string fieldTemp = Field.replace('.','#');
            list<string> fieldSplit = fieldTemp.split('#');
            if(fieldSplit.size() == 2){
            	csvString += '\n'+fieldSplit[0]+','+fieldSplit[1]+',PermissionsRead,'+ (ob1 == Null ? 'FALSE' : String.ValueOf(ob1.PermissionsRead))+','+(ob2 == Null ? 'FALSE' : String.ValueOf(ob2.PermissionsRead));
            	csvString += '\n'+fieldSplit[0]+','+fieldSplit[1]+',PermissionsEdit,'+ (ob1 == Null ? 'FALSE' : String.ValueOf(ob1.PermissionsEdit))+','+(ob2 == Null ? 'FALSE' : String.ValueOf(ob2.PermissionsEdit)); 	
            }else{
            	csvString += '\n'+Field+','+Field+',PermissionsRead,'+ (ob1 == Null ? 'FALSE' : String.ValueOf(ob1.PermissionsRead))+','+(ob2 == Null ? 'FALSE' : String.ValueOf(ob2.PermissionsRead));
            	csvString += '\n'+Field+','+Field+',PermissionsEdit,'+ (ob1 == Null ? 'FALSE' : String.ValueOf(ob1.PermissionsEdit))+','+(ob2 == Null ? 'FALSE' : String.ValueOf(ob2.PermissionsEdit)); 	    
            }   
        }
        Attachment att = new Attachment();
        att.Body = Blob.valueOf(csvString);
        att.ContentType = 'text/csv';
        att.Name = 'Field.csv';
        att.ParentId = '0010n000016zYrD';
        insert att;
    }
