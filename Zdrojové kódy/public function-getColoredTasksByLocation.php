
//ukázka php funkce
//funkce vrací tabulku s názvem lokace a počtem úkolů, tato tabulka je dále zpracovávána v jiné funkci 

public function getColoredTasksByLocation(int $locationId)
    {
        $equipments = $this->equipmentRepository->getEquipmentByLocation($locationId);
        $tasksArray= ["green" => "", "yellow" => "", "red" => ""];

        foreach($equipments as $equipment)
        {
            foreach($equipment->related(GeneralTaskRepository::TABLE_NAME) as $genTask)
            {
                foreach($genTask->related(TaskRepository::TABLE_NAME) as $task)
                {
                    $daysToExpire = ((new DateTime())->diff($task["date_to"], false)->format("%r%a"))+7;

                    if($daysToExpire >= 7)
                        $tasksArray["green"] += $task;

                    elseif($daysToExpire > 0 && $daysToExpire < 7)
                        $tasksArray["yellow"] += $task;

                    else
                        $tasksArray["red"] += $task;
    
                }

            }
        }
        return $tasksArray;
    }