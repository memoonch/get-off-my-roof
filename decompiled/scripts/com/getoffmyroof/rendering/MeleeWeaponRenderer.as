package com.getoffmyroof.rendering
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.rendering.AnimationRenderer;
   import com.whatthefawk.weapons.melee.MeleeWeapon;
   import flash.display.DisplayObjectContainer;
   
   public class MeleeWeaponRenderer extends AnimationRenderer
   {
      
      public var weaponLineColor:uint = 0;
      
      public var weaponLineThickness:int = 3;
      
      public var isBulbLineVisible:Boolean = false;
      
      private var m_weapon:MeleeWeapon;
      
      public var isWeaponLineVisible:Boolean = false;
      
      public function MeleeWeaponRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object)
      {
         super(param1,param2,param3,param4);
         if(param4.weaponLineColor != null)
         {
            this.weaponLineColor = param4.weaponLineColor;
         }
         if(param4.weaponLineThickness != null)
         {
            this.weaponLineColor = param4.weaponLineThickness;
         }
         if(param4.isWeaponLineVisible != null)
         {
            this.isWeaponLineVisible = param4.isWeaponLineVisible;
         }
         if(param4.isBulbLineVisible != null)
         {
            this.isBulbLineVisible = param4.isBulbLineVisible;
         }
         this.m_weapon = param1 as MeleeWeapon;
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:int = this.m_weapon.currentAngle.toDegrees();
         _container.rotation = _loc1_;
         _container.visible = this.m_weapon.isAttacking;
         if(this.isWeaponLineVisible)
         {
            g.lineStyle(this.weaponLineThickness,this.weaponLineColor);
            g.moveTo(0,0);
            g.lineTo(this.m_weapon.length,0);
         }
         if(this.isBulbLineVisible)
         {
            g.lineStyle(this.weaponLineThickness,this.weaponLineColor);
            g.drawCircle(this.m_weapon.length,0,this.m_weapon.bulbRadius);
         }
      }
   }
}

