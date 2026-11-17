package com.whatthefawk.particleEffects
{
   import com.whatthefawk.math.Vector2D;
   import flash.events.EventDispatcher;
   import org.flintparticles.common.events.EmitterEvent;
   import org.flintparticles.twoD.emitters.Emitter2D;
   
   public class ParticleEffect extends EventDispatcher
   {
      
      protected var _numEmittersComplete:int;
      
      protected var _lifeTime:int = 5000;
      
      protected var _timePasssed:int = 0;
      
      protected var _isComplete:Boolean;
      
      protected var _emitters:Array;
      
      protected var _numEmitters:int;
      
      protected var _target:Vector2D;
      
      public function ParticleEffect(param1:ParticleEffectParams)
      {
         super();
         this._target = param1.target;
         this._emitters = param1.emitters;
         this._numEmitters = 0;
         this._numEmittersComplete = 0;
         this._isComplete = false;
      }
      
      public function stop() : void
      {
         var _loc1_:Emitter2D = null;
         for each(_loc1_ in this._emitters)
         {
            _loc1_.stop();
         }
      }
      
      public function get isComplete() : Boolean
      {
         return this._isComplete;
      }
      
      public function update(param1:int) : void
      {
         if(this._isComplete)
         {
            return;
         }
         this._timePasssed += param1;
         if(this._timePasssed > this._lifeTime)
         {
            this._isComplete = true;
            dispatchEvent(new ParticleEffectEvent(ParticleEffectEvent.COMPLETE));
         }
      }
      
      public function get emitters() : Array
      {
         return this._emitters;
      }
      
      public function addEmitter(param1:Emitter2D) : void
      {
         param1.addEventListener(EmitterEvent.EMITTER_EMPTY,this.onEmitterEmpty,false,0,true);
         param1.addEventListener(EmitterEvent.EMITTER_UPDATED,this.onEmitterUpdate,false,0,true);
         param1.addEventListener(EmitterEvent.COUNTER_COMPLETE,this.onEmitterComplete,false,0,true);
         this._emitters.push(param1);
         ++this._numEmitters;
      }
      
      public function get target() : Vector2D
      {
         return this._target;
      }
      
      public function killAllParticles() : void
      {
         var _loc1_:Emitter2D = null;
         for each(_loc1_ in this._emitters)
         {
            _loc1_.killAllParticles();
         }
      }
      
      public function dispose() : void
      {
         this._target = null;
         this._emitters = null;
      }
      
      public function onEmitterComplete(param1:EmitterEvent) : void
      {
         ++this._numEmittersComplete;
      }
      
      public function start() : void
      {
         var _loc1_:Emitter2D = null;
         for each(_loc1_ in this._emitters)
         {
            _loc1_.start();
         }
      }
      
      public function setPosition(param1:int, param2:int) : void
      {
         var _loc3_:Emitter2D = null;
         for each(_loc3_ in this._emitters)
         {
            _loc3_.x = param1;
            _loc3_.y = param2;
         }
      }
      
      public function resume() : void
      {
         var _loc1_:Emitter2D = null;
         for each(_loc1_ in this._emitters)
         {
            _loc1_.resume();
         }
      }
      
      public function pause() : void
      {
         var _loc1_:Emitter2D = null;
         for each(_loc1_ in this._emitters)
         {
            _loc1_.pause();
         }
      }
      
      public function onEmitterUpdate(param1:EmitterEvent) : void
      {
         var _loc2_:Emitter2D = null;
         if(this._target)
         {
            _loc2_ = param1.currentTarget as Emitter2D;
            _loc2_.x = this._target.x;
            _loc2_.y = this._target.y;
         }
      }
      
      public function runAhead(param1:int, param2:int = 10) : void
      {
         var _loc3_:Emitter2D = null;
         for each(_loc3_ in this._emitters)
         {
            _loc3_.runAhead(param1,param2);
         }
      }
      
      public function onEmitterEmpty(param1:EmitterEvent) : void
      {
         if(this._numEmittersComplete == this._numEmitters)
         {
            this._isComplete = true;
            dispatchEvent(new ParticleEffectEvent(ParticleEffectEvent.COMPLETE));
         }
      }
   }
}

