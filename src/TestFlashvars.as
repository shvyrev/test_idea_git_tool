/**
 * Created by s.shvyrev on 07.04.2014.
 */
package {
import flash.display.Sprite;

public class TestFlashvars extends Sprite {
    public function TestFlashvars() {

        var key:String = "0123456789";
        var value:String = "value";

        var name:String = "set" + key.charAt(0).toUpperCase() + key.substr(1);
        var comment:String = "Param: " + key + "=" + value;
        var method:String = key.toLowerCase();
//        if (method.substr(0, 2) == "on") {

        trace(method.substr(0, 2), name, comment);
        trace(method.substr(2));
    }
}
}
