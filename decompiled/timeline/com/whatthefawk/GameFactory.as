package com.whatthefawk
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.EntityParams;
   import com.whatthefawk.entity.GameWorld;
   import com.whatthefawk.entity.ICollisionProcess;
   import com.whatthefawk.entity.IMessageDispatcher;
   import com.whatthefawk.rendering.ARenderer;
   import com.whatthefawk.rendering.GameWorldRenderer;
   import flash.display.DisplayObjectContainer;
   import flash.utils.Dictionary;
   
   public class GameFactory
   {
      
      private var m_gameWorldMessageDispatcher:IMessageDispatcher;
      
      private var m_paramMap:Dictionary;
      
      private var m_gameWorld:GameWorld;
      
      private var m_gameWorldRenderer:GameWorldRenderer;
      
      public function GameFactory()
      {
         super();
         this.m_paramMap = new Dictionary();
      }
      
      public function createGameWorld(param1:*, param2:*, param3:DisplayObjectContainer, param4:ICollisionProcess = null, param5:IMessageDispatcher = null) : GameWorld
      {
         this.m_gameWorld = new GameWorld(param1,param2,param4);
         this.m_gameWorldRenderer = new GameWorldRenderer(this.m_gameWorld,param3);
         this.m_gameWorld.addRenderer(this.m_gameWorldRenderer);
         if(param5)
         {
            this.m_gameWorldMessageDispatcher = param5;
            this.m_gameWorldMessageDispatcher.setGameWorld(this.m_gameWorld);
         }
         return this.m_gameWorld;
      }
      
      public function registerEntity(param1:EntityParams, param2:* = false) : void
      {
         if(param1.type == null)
         {
            throw new Error("<GameFactory::registerEntity> Entity a_params.type can not be null");
         }
         if(this.m_paramMap[param1.type] != null && !param2)
         {
            throw new Error("<GameFactory::registerEntity> An Entity with a_params.type = " + param1.type + "; has already been registered.");
         }
         this.m_paramMap[param1.type] = param1;
      }
      
      public function getRenderer(param1:Entity, param2:Class, param3:Object = null) : ARenderer
      {
         if(this.m_gameWorld == null || this.m_gameWorldRenderer == null)
         {
            throw new Error("<GameFactory::getRenderer> GameWorld and GameWorldRenderer must be initialized before calling getRenderer.");
         }
         return new param2(param1,this.m_gameWorld.camera,this.m_gameWorldRenderer.getLayer(param1.layer),param3 == null ? {} : param3);
      }
      
      public function getGameWorld() : GameWorld
      {
         return this.m_gameWorld;
      }
      
      public function dispose() : void
      {
         var _loc1_:Object = null;
         for(_loc1_ in this.m_paramMap)
         {
            delete this.m_paramMap[_loc1_];
         }
         this.m_paramMap = null;
         this.m_gameWorld = null;
         this.m_gameWorldRenderer = null;
      }
      
      public function getEntity(param1:String, param2:Entity = null) : *
      {
         var _loc3_:Entity = null;
         var _loc4_:EntityParams = null;
         var _loc5_:ARenderer = null;
         _loc4_ = this.m_paramMap[param1];
         if(_loc4_ == null)
         {
            throw new Error("<GameFactory::getEntity> " + param1 + " is not a registered Entity type!");
         }
         if(!param2)
         {
            param2 = this.m_gameWorld;
         }
         var _loc6_:String = param1;
         switch(0)
         {
         }
         if(_loc4_.messageDispatcher == null)
         {
            _loc4_.messageDispatcher = this.m_gameWorldMessageDispatcher;
         }
         _loc3_ = new _loc4_.customClass(_loc4_);
         if(!(_loc3_ is Entity))
         {
            throw new Error("<GameWorld::getEntity> params.customClass must extend Entity.");
         }
         param2.addChild(_loc3_);
         if(_loc4_.rendererClass != null)
         {
            this.m_gameWorld.addRenderer(this.getRenderer(_loc3_,_loc4_.rendererClass,_loc4_.rendererData));
         }
         return _loc3_;
      }
      
      public function getEntityParams(param1:String) : EntityParams
      {
         if(this.m_paramMap[param1] == null)
         {
            throw new Error("<GameFactory::getEntityParams> Type " + param1 + " not recognized.");
         }
         return this.m_paramMap[param1];
      }
   }
}

