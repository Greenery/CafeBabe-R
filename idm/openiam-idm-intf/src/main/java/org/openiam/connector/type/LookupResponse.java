
package org.openiam.connector.type;

import org.openiam.provision.type.ExtensibleAttribute;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;
import java.util.List;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "LookupResponse", propOrder = {
    "user"
})
public class LookupResponse    extends ResponseType
{

    UserValue user;

    public UserValue getUser() {
        return user;
    }

    public void setUser(UserValue user) {
        this.user = user;
    }
}
