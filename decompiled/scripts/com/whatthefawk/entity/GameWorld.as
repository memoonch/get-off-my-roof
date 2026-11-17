package com.whatthefawk.entity
{
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.rendering.ARenderer;
   import com.whatthefawk.utils.Input;
   import flash.utils.Dictionary;
   
   public class GameWorld extends Entity
   {
      
      private var m_entitiesToRemove:Array;
      
      private var m_entitiesToAdd:Array;
      
      public var camera:GameCamera;
      
      private var m_collisionProcess:ICollisionProcess;
      
      private var m_rendererCount:int;
      
      private var m_renderers:Dictionary;
      
      public function GameWorld(param1:Vector2D, param2:Vector2D, param3:ICollisionProcess = null)
      {
         var _loc4_:EntityParams = new EntityParams();
         _loc4_.forceId = "GameWorld";
         super(_loc4_);
         this.m_entitiesToAdd = [];
         this.m_entitiesToRemove = [];
         this.m_collisionProcess = param3;
         this.m_renderers = new Dictionary();
         this.m_rendererCount = 0;
         bounds.set(param1.dividedBy(2),param1.x,param1.y);
         this.camera = new GameCamera(this,param2.x,param2.y);
         Input.instance.activateWorldMouse(this,0,0);
      }
      
      private function addEntities() : void
      {
         var _loc1_:Entity = null;
         for each(_loc1_ in this.m_entitiesToAdd)
         {
            super.addChild(_loc1_);
         }
         this.m_entitiesToAdd = [];
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         bounds.setSize(param1,param2);
         dispatchEvent(new EntityEvent(EntityEvent.RESIZE,{
            "width":param1,
            "height":param2
         }));
      }
      
      public function addRenderer(param1:ARenderer) : void
      {
         ++this.m_rendererCount;
         this.m_renderers[param1.entity.id] = param1;
      }
      
      private function updateRenderers(param1:int) : void
      {
         var _loc2_:ARenderer = null;
         for each(_loc2_ in this.m_renderers)
         {
            _loc2_.update(param1);
         }
      }
      
      override public function update(param1:int) : void
      {
         updateChildren(param1);
         this.processCollisions();
         this.addEntities();
         this.removeEntities();
         this.updateRenderers(param1);
      }
      
      private function processCollisions() : void
      {
         if(!this.m_collisionProcess)
         {
            return;
         }
         this.m_collisionProcess.processCollisions(getChildren());
      }
      
      public function getScreenPos(param1:Vector2D) : Vector2D
      {
         var _loc2_:Number = this.camera.currentPos.x - this.camera.bounds.halfWidth;
         var _loc3_:Number = this.camera.currentPos.y - this.camera.bounds.halfHeight;
         var _loc4_:Number = param1.x - _loc2_;
         var _loc5_:Number = param1.y - _loc3_;
         return new Vector2D(_loc4_,_loc5_);
      }
      
      override public function dispose() : void
      {
         this.removeEntities();
         this.camera = null;
         this.m_entitiesToAdd = null;
         this.m_entitiesToRemove = null;
         this.m_renderers = null;
         this.m_collisionProcess = null;
         super.dispose();
      }
      
      private function removeRenderer(param1:String) : void
      {
         --this.m_rendererCount;
         ARenderer(this.m_renderers[param1]).dispose();
         delete this.m_renderers[param1];
      }
      
      private function removeEntities() : void
      {
         var _loc1_:Entity = null;
         for each(_loc1_ in this.m_entitiesToRemove)
         {
            this.removeRenderer(_loc1_.id);
            super.removeChild(_loc1_.id);
         }
         this.m_entitiesToRemove = [];
      }
      
      override public function removeChild(param1:String) : void
      {
         var _loc2_:Entity = getChildByID(param1);
         if(this.m_entitiesToRemove.indexOf(_loc2_) != -1)
         {
            return;
         }
         if(_loc2_ == null)
         {
            throw new Error("<GameWorld::removeChild> No Entity matches the id: " + param1);
         }
         this.m_entitiesToRemove.push(_loc2_);
      }
      
      public function getRenderer(param1:String) : ARenderer
      {
         return this.m_renderers[param1];
      }
      
      override public function addChild(param1:Entity) : void
      {
         if(this.m_entitiesToAdd.indexOf(param1) != -1)
         {
            throw new Error("<GameWorld::addChild()> This Entity is already queued for addition.");
         }
         if(getChildByID(param1.id) != null)
         {
            throw new Error("<GameWorld::addChild()> An Entity with this id already exists. Ensure ids are unique.");
         }
         var _loc2_:int = int(this.m_entitiesToAdd.length);
         while(--_loc2_ > -1)
         {
            if(param1.id == this.m_entitiesToAdd[_loc2_].id)
            {
               throw new Error("<GameWorld::addChild()> An Entity with this id is already queued for addition. Ensure ids are unique.");
            }
         }
         this.m_entitiesToAdd.push(param1);
      }
   }
}

