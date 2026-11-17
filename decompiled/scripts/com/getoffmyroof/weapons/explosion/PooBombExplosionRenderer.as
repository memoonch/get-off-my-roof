package com.getoffmyroof.weapons.explosion
{
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.rendering.AnimationRenderer;
   import com.whatthefawk.weapons.explosion.ExplosionEvent;
   import flash.display.DisplayObjectContainer;
   
   public class PooBombExplosionRenderer extends AnimationRenderer
   {
      
      private var m_explosion:PooBombExplosion;
      
      private var m_animationID:String;
      
      public function PooBombExplosionRenderer(param1:PooBombExplosion, param2:GameCamera, param3:DisplayObjectContainer, param4:Object)
      {
         super(param1,param2,param3,param4);
         this.m_explosion = param1;
         this.m_explosion.addEventListener(ExplosionEvent.EXPLODE,this.onExplode,false,0,true);
      }
      
      private function onExplode(param1:ExplosionEvent) : void
      {
         var _loc2_:String = this.m_explosion.explodedInAir ? "AirExplosion" : "GroundExplosion";
         _animationPlayer.play(_loc2_);
      }
      
      override public function dispose() : void
      {
         this.m_explosion.removeEventListener(ExplosionEvent.EXPLODE,this.onExplode);
         this.m_explosion = null;
         super.dispose();
      }
   }
}

