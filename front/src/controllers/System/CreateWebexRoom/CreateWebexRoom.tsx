import { createWebexRoomApi } from "../../../api/EvaluationRoomApi";
import { useData } from "../../../modules/Server/QueryHook";

function CreateWebexRoom() {
  const { data, refetch } = useData<string, any>(
    ["createWebex", null],
    () => createWebexRoomApi(),
    {
      onSuccess: (data) => {
        // console.log(data.data);
        let url = String(data.data);
        window.location.href = url;
      },
    }
  );
  //eomky2005@gmail.com
  return <></>;
}

export default CreateWebexRoom;
