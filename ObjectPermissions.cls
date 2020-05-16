//For Object Permission
string csvString = 'Object Name,Permission Name,Profile 1,Profile 2';
Set<string> sObjectTypeSet = new Set<string>();
Map<string,ObjectPermissions> obMap1 = new Map<string,ObjectPermissions>();
Map<string,ObjectPermissions> obMap2 = new Map<string,ObjectPermissions>();
for(ObjectPermissions ob1 : [SELECT SObjectType, PermissionsRead, PermissionsCreate, PermissionsEdit, PermissionsDelete, PermissionsViewAllRecords, PermissionsModifyAllRecords FROM ObjectPermissions WHERE Parent.Profile.Name='Sales Engineer - US' ORDER BY SObjectType]){
	obMap1.put(ob1.SObjectType,ob1);
	sObjectTypeSet.add(ob1.SObjectType);    
}
for(ObjectPermissions ob2 : [SELECT SObjectType, PermissionsRead, PermissionsCreate, PermissionsEdit, PermissionsDelete, PermissionsViewAllRecords, PermissionsModifyAllRecords FROM ObjectPermissions WHERE Parent.Profile.Name='Sales Engineer' ORDER BY SObjectType]){
	obMap2.put(ob2.SObjectType,ob2); 
    sObjectTypeSet.add(ob2.SObjectType); 
}

for(string sObjectType : sObjectTypeSet){
    ObjectPermissions ob1 = obMap1.get(sObjectType);
    ObjectPermissions ob2 = obMap2.get(sObjectType);
    csvString += '\n'+sObjectType+',PermissionsRead,'+ (ob1 == Null ? '#N/A' : String.ValueOf(ob1.PermissionsRead))+','+(ob2 == Null ? '#N/A' : String.ValueOf(ob2.PermissionsRead));
    csvString += '\n'+sObjectType+',PermissionsCreate,'+ (ob1 == Null ? '#N/A' : String.ValueOf(ob1.PermissionsCreate))+','+(ob2 == Null ? '#N/A' : String.ValueOf(ob2.PermissionsCreate));
    csvString += '\n'+sObjectType+',PermissionsEdit,'+ (ob1 == Null ? '#N/A' : String.ValueOf(ob1.PermissionsEdit))+','+(ob2 == Null ? '#N/A' : String.ValueOf(ob2.PermissionsEdit));
    csvString += '\n'+sObjectType+',PermissionsDelete,'+ (ob1 == Null ? '#N/A' : String.ValueOf(ob1.PermissionsDelete))+','+(ob2 == Null ? '#N/A' : String.ValueOf(ob2.PermissionsDelete));
    csvString += '\n'+sObjectType+',PermissionsViewAllRecords,'+ (ob1 == Null ? '#N/A' : String.ValueOf(ob1.PermissionsViewAllRecords))+','+(ob2 == Null ? '#N/A' : String.ValueOf(ob2.PermissionsViewAllRecords));
    csvString += '\n'+sObjectType+',PermissionsModifyAllRecords,'+ (ob1 == Null ? '#N/A' : String.ValueOf(ob1.PermissionsModifyAllRecords))+','+(ob2 == Null ? '#N/A' : String.ValueOf(ob2.PermissionsModifyAllRecords));  
       
}
Attachment att = new Attachment();
att.Body = Blob.valueOf(csvString);
att.ContentType = '.csv';
att.Name = 'Seus.csv';
att.ParentId = '0010n000016zYrD';
insert att;