import "@dotlottie/player-component";
import "@lottiefiles/lottie-player";

export const Loading = () => {
  return (
    <dotlottie-player
      autoplay="true"
      loop=""
      src={`${window.location.origin}/animation/120096-ai-assistant-animation.lottie`}
      id="i8vee"
      speed="1"
      class="lottieanimation"
      background="transparent"
      style={{
        width: "500px",
        height: "300px",
        overflow: " hidden",
        margin: "auto",
        cursor: "default",
        background: " transparent",
      }}
    ></dotlottie-player>
  );
};
export const Confirm = () => {
  return (
    <lottie-player
      autoplay="true"
      loop=""
      src={`${window.location.origin}/animation/98621-success-status.json`}
      id="8tqv9"
      speed="3"
      class="lottieanimation"
      background="transparent"
      style={{
        width: "114px",
        height: "112px",
        overflow: "hidden",
        margin: "auto",
        cursor: "default",
        background: " transparent",
      }}
    ></lottie-player>
  );
};
export const Finger = () => {
  return (
    <lottie-player
      autoplay="true"
      loop=""
      src={`${window.location.origin}/animation/5289-finger-print-scan.json`}
      id="r9wtf"
      speed="1"
      class="lottieanimation"
      background="transparent"
      style={{
        width: "300px",
        height: "300px",
        overflow: "hidden",
        cursor: "default",
        background: " transparent",
      }}
    ></lottie-player>
  );
};
export const BlockChain = () => {
  return (
    <lottie-player
      autoplay="true"
      loop=""
      src={`${window.location.origin}/animation/blockChainLottie.json`}
      id="eyw21"
      speed="1"
      class="lottieanimation"
      background="transparent"
      style={{
        width: "300px",
        height: "300px",
        overflow: "hidden",
        cursor: "default",
        background: " transparent",
      }}
    ></lottie-player>
  );
};
