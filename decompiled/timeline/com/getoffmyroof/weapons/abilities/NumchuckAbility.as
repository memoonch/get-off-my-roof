package com.getoffmyroof.weapons.abilities
{
   import com.getoffmyroof.entity.Player;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.weapons.IWeaponAbility;
   
   public class NumchuckAbility implements IWeaponAbility
   {
      
      public function NumchuckAbility()
      {
         super();
      }
      
      public function applyTo(param1:*) : void
      {
         var _loc2_:Player = Player(param1);
         _loc2_.modifyJump(2,new Vector2D(0,-900),new Vector2D(0,50));
      }
   }
}

