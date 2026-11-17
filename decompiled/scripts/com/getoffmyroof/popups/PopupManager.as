package com.getoffmyroof.popups
{
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.GameFactory;
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.EntityEvent;
   import com.whatthefawk.math.Vector2D;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class PopupManager extends EventDispatcher
   {
      
      private var m_popupCount:int = 0;
      
      private var m_popupsMax:int = 15;
      
      private var m_gameFactory:GameFactory;
      
      public function PopupManager()
      {
         super();
         this.m_gameFactory = GameComponents.instance.getGameFactory();
      }
      
      public function deployPointsPopup(param1:Vector2D, param2:int) : void
      {
         this.deployPopup("PointsPopup",param1,{"points":param2});
      }
      
      public function deployPopup(param1:String, param2:Vector2D, param3:Object) : void
      {
         var _loc5_:String = null;
         if(this.m_popupCount >= this.m_popupsMax)
         {
            return;
         }
         var _loc4_:Entity = this.m_gameFactory.getEntity(param1);
         if(!_loc4_)
         {
            throw new Error("<PopupManager::deployPopup> No popup (entity) with the ID " + param1 + " exists.");
         }
         ++this.m_popupCount;
         _loc4_.addEventListener(EntityEvent.DISPOSE,this.onPopupDispose,false,0,true);
         _loc4_.newPos.x = param2.x;
         _loc4_.newPos.y = param2.y;
         for(_loc5_ in param3)
         {
            if(_loc5_ in _loc4_)
            {
               _loc4_[_loc5_] = param3[_loc5_];
            }
         }
      }
      
      protected function onPopupDispose(param1:Event) : void
      {
         var _loc2_:Entity = param1.target as Entity;
         _loc2_.removeEventListener(EntityEvent.DISPOSE,this.onPopupDispose);
         --this.m_popupCount;
      }
   }
}

