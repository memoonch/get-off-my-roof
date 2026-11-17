package com.getoffmyroof.popups
{
   import com.whatthefawk.entity.MovingEntity;
   import flash.events.Event;
   
   public class APopup extends MovingEntity
   {
      
      public function APopup(param1:PopupParams = null)
      {
         super(param1);
      }
      
      override protected function onLifeTimeComplete(param1:Event) : void
      {
         super.onLifeTimeComplete(param1);
         parent.removeChild(id);
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
      }
   }
}

