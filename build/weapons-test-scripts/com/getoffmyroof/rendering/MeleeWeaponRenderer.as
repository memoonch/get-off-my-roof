package com.getoffmyroof.rendering
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.rendering.AnimationRenderer;
   import com.whatthefawk.weapons.melee.MeleeWeapon;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import com.getoffmyroof.assets.Assets;
   import com.getoffmyroof.engine.GameComponents;
   
   public class MeleeWeaponRenderer extends AnimationRenderer
   {
      
      public var weaponLineColor:uint = 0;
      
      public var weaponLineThickness:int = 3;
      
      public var isBulbLineVisible:Boolean = false;
      
      private var m_weapon:MeleeWeapon;
      private var m_remaster:Sprite;
      
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
         var artClass:Class;
         switch(param1.type)
         {
            case "Newspaper": artClass=Assets.NEWSPAPER_ANIMATIONS; break;
            case "Broom": artClass=Assets.BROOM_ANIMATIONS; break;
            case "GolfClub": artClass=Assets.GOLF_CLUB_ANIMATIONS; break;
            case "Mop": artClass=Assets.MOP_ANIMATIONS; break;
            case "Rake": artClass=Assets.RAKE_ANIMATIONS; break;
            case "BaseballBat": artClass=Assets.BASEBALL_BAT_ANIMATIONS; break;
            case "PoolStick": artClass=Assets.POOL_STICK_ANIMATIONS; break;
            case "Numchucks": artClass=Assets.NUMCHUCK_ANIMATIONS; break;
            case "Shovel": artClass=Assets.SHOVEL_ANIMATIONS; break;
         }
         if(artClass != null)
         {
            this.m_remaster = new Sprite();
            this.m_remaster.mouseEnabled = false;
            this.m_remaster.mouseChildren = false;
            var art:MovieClip = new artClass() as MovieClip;
            art.gotoAndStop(1);
            art.y = -2;
            this.m_remaster.addChild(art);
            this.m_remaster.visible = false;
            GameComponents.instance.getComponent("GameScreen").addChild(this.m_remaster);
         }
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         if(this.m_remaster == null)return;
         _animationPlayer.visible = false;
         this.m_remaster.visible = _container.visible;
         this.m_remaster.x = _container.x + 106.6666667;
         this.m_remaster.y = _container.y;
         this.m_remaster.rotation = _container.rotation;
         this.m_remaster.scaleX = _container.scaleX;
         this.m_remaster.scaleY = _container.scaleY;
         this.m_remaster.alpha = _container.alpha;
      }

      override public function dispose() : void
      {
         if(this.m_remaster != null && this.m_remaster.parent != null)this.m_remaster.parent.removeChild(this.m_remaster);
         this.m_remaster = null;
         super.dispose();
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

