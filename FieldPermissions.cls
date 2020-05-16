//For Field Permission
string csvString = 'Object Name,Field Name,Permission Name,Sales Engineer - US,Sales Engineer';
Set<string> fieldSet = new Set<string>();
Map<string,FieldPermissions> obMap1 = new Map<string,FieldPermissions>();
Map<string,FieldPermissions> obMap2 = new Map<string,FieldPermissions>();
for(FieldPermissions ob1 : [SELECT Field, PermissionsRead,PermissionsEdit,Parent.Profile.Name FROM FieldPermissions WHERE Parent.Profile.Name = 'System Administrator' Order By SObjectType]){
	obMap1.put(ob1.Field,ob1);
	fieldSet.add(ob1.Field);    
}
for(FieldPermissions ob2 : [SELECT Field, PermissionsRead, PermissionsEdit, Parent.Profile.Name FROM FieldPermissions WHERE Parent.Profile.Name = 'Standard User' Order By SObjectType]){
	obMap2.put(ob2.Field,ob2); 
    fieldSet.add(ob2.Field); 
}

for(string Field : fieldSet){
    FieldPermissions ob1 = obMap1.get(Field);
    FieldPermissions ob2 = obMap2.get(Field);
    string fieldTemp = Field.replace('.','#');
	list<string> fieldSplit = fieldTemp.split('#');
    csvString += '\n'+fieldSplit[0]+','+fieldSplit[1]+',PermissionsRead,'+ (ob1 == Null ? '#N/A' : String.ValueOf(ob1.PermissionsRead))+','+(ob2 == Null ? '#N/A' : String.ValueOf(ob2.PermissionsRead));
	csvString += '\n'+fieldSplit[0]+','+fieldSplit[1]+',PermissionsEdit,'+ (ob1 == Null ? '#N/A' : String.ValueOf(ob1.PermissionsEdit))+','+(ob2 == Null ? '#N/A' : String.ValueOf(ob2.PermissionsEdit)); 	
       
}
Attachment att = new Attachment();
att.Body = Blob.valueOf(csvString);
att.ContentType = '.csv';
att.Name = 'Field.csv';
att.ParentId = '0011C00002l5FyeQAE';
insert att;