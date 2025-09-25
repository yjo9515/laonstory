import DaumPostCode, { Address } from "react-daum-postcode";
import { useResetRecoilState } from "recoil";
import { contentModalState } from "../modules/Client/Modal/Modal";

interface DaumPostProps {
  fn: (
    code: string,
    address: string,
    latLng: {
      longitude: string;
      latitude: string;
    }
  ) => void;
}

export const DaumPost = ({ fn }: DaumPostProps) => {
  // const kakao = (window as any).kakao;
  const resetContentModal = useResetRecoilState(contentModalState);

  const handleComplete = (data: Address) => {
    let fullAddress = data.address;
    let extraAddress = "";

    let latLng = {
      longitude: "",
      latitude: "",
    };

    if (data.addressType === "R") {
      if (data.bname !== "") {
        extraAddress += data.bname;
      }
      if (data.buildingName !== "") {
        extraAddress += extraAddress !== "" ? `, ${data.buildingName}` : data.buildingName;
      }
      fullAddress += extraAddress !== "" ? ` (${extraAddress})` : "";
    }

    if (fn) {
      resetContentModal();
      fn(data.zonecode, fullAddress, latLng);
    }

    // fullAddress -> 전체 주소반환
    // let geocoder = new kakao.maps.services.Geocoder();

    // geocoder.addressSearch(fullAddress, function (result: any, status: any) {
    //   // 정상적으로 검색이 완료됐으면
    //   if (status === kakao.maps.services.Status.OK) {
    //     let coords = new kakao.maps.LatLng(result[0].y, result[0].x);

    //     latLng.longitude = coords.La;
    //     latLng.latitude = coords.Ma;

    //     if (fn) {
    //       resetContentModal();
    //       fn(data.zonecode, fullAddress, latLng);
    //     }
    //   }
    // });
  };
  return <DaumPostCode onComplete={handleComplete} style={{ height: "400px" }} />;
};
export default DaumPost;
