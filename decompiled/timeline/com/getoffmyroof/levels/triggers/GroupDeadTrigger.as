package com.getoffmyroof.levels.triggers
{
   import com.getoffmyroof.levels.spawners.SpawnGroup;
   
   public class GroupDeadTrigger extends AGroupTrigger
   {
      
      public function GroupDeadTrigger(param1:SpawnGroup)
      {
         super(param1);
      }
      
      override public function test() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:Boolean = true;
         for each(_loc2_ in spawnGroup.members)
         {
            if(!_loc2_.isDead)
            {
               _loc1_ = false;
               break;
            }
         }
         if(_loc1_ && !isTriggered)
         {
            activate();
         }
      }
   }
}

