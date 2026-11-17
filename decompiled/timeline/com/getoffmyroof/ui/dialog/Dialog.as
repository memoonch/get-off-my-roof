package com.getoffmyroof.ui.dialog
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Dialog extends MovieClip
   {
      
      public static const YES_NO:String = "yes_no";
      
      public static const OK:String = "ok";
      
      public var btn_no:btn_no_class;
      
      public var btn_yes:btn_yes_class;
      
      protected var _text:TextField;
      
      public var text:TextField;
      
      protected var _eventListeners:Array = [];
      
      protected var _type:String;
      
      public var btn_ok:btn_ok_class;
      
      public function Dialog(param1:String, param2:String)
      {
         super();
         this._text = this.text;
         this._text.text = param2;
         this._type = param1;
         if(this._type == Dialog.YES_NO)
         {
            this.btn_no.addEventListener(MouseEvent.CLICK,this.onClickNo,false,0,true);
            this.btn_yes.addEventListener(MouseEvent.CLICK,this.onClickYes,false,0,true);
            this.btn_ok.alpha = 0;
            this.btn_ok.visible = false;
         }
         else
         {
            if(this._type != Dialog.OK)
            {
               throw new Error("<Dialog> Invalid dialog type.");
            }
            this.btn_ok.addEventListener(MouseEvent.CLICK,this.onClickOk,false,0,true);
            this.btn_no.alpha = 0;
            this.btn_yes.alpha = 0;
            this.btn_no.visible = false;
            this.btn_yes.visible = false;
         }
      }
      
      private function onClickYes(param1:MouseEvent) : void
      {
         dispatchEvent(new DialogEvent(DialogEvent.CLICKED,{"button":"yes"}));
         this.close();
      }
      
      private function clearEvents() : void
      {
         var _loc1_:Object = null;
         if(this._eventListeners.length == 0)
         {
            return;
         }
         for each(_loc1_ in this._eventListeners)
         {
            removeEventListener(_loc1_.type,_loc1_.listener,_loc1_.useCapture);
         }
         this._eventListeners = null;
      }
      
      private function close() : void
      {
         this.clearEvents();
         parent.removeChild(this);
      }
      
      private function onClickNo(param1:MouseEvent) : void
      {
         dispatchEvent(new DialogEvent(DialogEvent.CLICKED,{"button":"no"}));
         this.close();
      }
      
      private function onClickOk(param1:MouseEvent) : void
      {
         dispatchEvent(new DialogEvent(DialogEvent.CLICKED,{"button":"ok"}));
         this.close();
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventListeners.push({
            "type":param1,
            "listener":param2,
            "useCapture":param3
         });
         super.addEventListener(param1,param2,param3,param4,param5);
      }
   }
}

