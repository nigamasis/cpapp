using {sap.sample.cpapp as inc} from '../db/schema';
using {Northwind as external} from './external/Northwind';
using {zmy_quotes as ext} from './external/zmy_quotes';


service incidentService {
    entity User          as
        select from inc.User {
            *
        }
        excluding {
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy
        };

    // @cds.query.limit: { default: 20, max: 100 }
    entity Incident      as
        select from inc.Incident
        excluding {
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy
        };

    entity Comments @(restrict: [{
        grant: 'READ',
        to   : 'Reader'
    }])                  as
        projection on inc.Comments
        excluding {
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy
        };

    // entity Comments      as
    //     projection on inc.Comments
    //     excluding {
    //         createdAt,
    //         createdBy,
    //         modifiedAt,
    //         modifiedBy
    //     };

    entity Products      as
        projection on external.Products {
            *,
            prod : Association to many User on prod.userID = ProductID
        };

    entity ETS_MY_QUOTES as
        select from ext.ETS_MY_QUOTES {
            *
        };

    // entity Customers as projection on external.Customers;

    function submitUser()                returns String;
    action   checkUser(userID : Integer) returns String;

    event addUser {
        uid    : type of inc.User : userID @mandatory;
        fname  : type of inc.User : name   @mandatory;
        gender : type of inc.User : gender @mandatory;
        prodID : type of inc.User : prodID;
    }
}
