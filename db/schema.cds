using { managed } from '@sap/cds/common';
using {Northwind as external} from '../srv/external/Northwind';


namespace sap.sample.cpapp;

entity User : managed {
    key userID: Integer;
    name: String @assert.notNull;
    incident: Association to many Incident on incident.requestor = $self;
    comments: Association to many Comments on comments.uid = $self;
    gender: Gender;
    prodID: Association to external.Products;
}

entity Incident : managed {
    key incID: Integer;
    title: String;
    description: String;
    requestor: Association to User @assert.integrity;
    comments: Association to many Comments on comments.Incid = $self;
}

entity Comments : managed {
    key commID: Integer;
    uid: Association to User;
    Incid: Association to Incident;
    reply: String;
}

type Gender : String enum{
    Male; Female; Trans;
}