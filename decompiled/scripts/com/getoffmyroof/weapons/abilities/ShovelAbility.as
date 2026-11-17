package com.getoffmyroof.weapons.abilities
{
   import com.getoffmyroof.entity.Player;
   import com.whatthefawk.weapons.IWeaponAbility;
   
   public class ShovelAbility implements IWeaponAbility
   {
      
      public function ShovelAbility()
      {
         super();
      }
      
      public function applyTo(param1:*) : void
      {
         var _loc2_:Player = Player(param1);
         _loc2_.maxForce /= 1.5;
      }
   }
}

