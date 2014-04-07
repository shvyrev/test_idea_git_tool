package {

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;
import flash.system.Security;
import flash.text.TextField;
import flash.utils.getTimer;

public class Main extends Sprite {
    private var _tf:TextField;
    public function Main() {

        Security.loadPolicyFile("http://servito.ru/crossdomain.xml");
        Security.allowDomain("*");
        Security.allowInsecureDomain("*");

        super.stage.align = StageAlign.TOP_LEFT;
        super.stage.scaleMode = StageScaleMode.NO_SCALE;

        this._tf = new TextField();
        this._tf.text = "output:\n";
        this._tf.selectable = false;
        addChild(this._tf);

        log("ei available:", ExternalInterface.available);

        if (ExternalInterface.available)
        {
            try
            {
                ExternalInterface.addCallback("alert", handler_externalInterface);
            }
            catch(error:Error)
            {
                log("Error: " + error);
            }
            catch(secError:SecurityError)
            {
                log("Security error: " + secError);
            }
        }
        else
        {
            log("ExternalInterface is not available");
        }

        super.stage.addEventListener(Event.RESIZE, handler_resize);
        super.stage.addEventListener(MouseEvent.MOUSE_DOWN, handler_mouse);

        handler_resize(null);
    }

    private function handler_resize(event:Event):void {
        this._tf.width = super.stage.stageWidth;
        this._tf.height = super.stage.stageHeight;
    }

    private function handler_externalInterface():void {
        log("handler_externalInterface");

//        dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
//
//        return;

        var event:MouseEvent = new MouseEvent(MouseEvent.MOUSE_DOWN);
        event.localX = Math.floor(Math.random()*super.stage.stageWidth);
        event.localY = Math.floor(Math.random()*super.stage.stageHeight);
        this.dispatchEvent(event);
    }

    public function log(...array):void {
        var i:uint;
        var length:uint = array.length;
        var result:String = "";

        for(i = 0; i < length; i++) {
            result += array[i].toString() + " ";
        }

        this._tf.appendText(getTimer() + " : " + result + "\n");
    }

    private function handler_mouse(event:MouseEvent):void {

        log("handler_mouse");

        try{
            goFullScreen();
//            super.stage.displayState = StageDisplayState.FULL_SCREEN;
        }catch (e:Error){
            log("error:", e.toString());
        }
    }

    public function goFullScreen():void
    {
        StageDisplayState.FULL_SCREEN;

        if (stage.displayState == StageDisplayState.NORMAL) {

            stage.displayState = StageDisplayState.FULL_SCREEN;

        } else {

            stage.displayState = StageDisplayState.NORMAL;

        }

    }
}
}
