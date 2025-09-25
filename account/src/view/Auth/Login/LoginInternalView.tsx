import styled from "styled-components";
import "@dotlottie/player-component";
import "@lottiefiles/lottie-player";

export default function LoginInternalView() {
  return (
    <LoginInternalViewBlock>
      <section>
        <div>
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
              overflow: "hidden",
              margin: "auto",
              cursor: "default",
              background: " transparent",
            }}
          ></dotlottie-player>
        </div>
        <div>페이지에 접속하고 있습니다. 잠시만 기다려주세요.</div>
      </section>
    </LoginInternalViewBlock>
  );
}

const LoginInternalViewBlock = styled.div`
  width: 100%;
  height: 100vh;
  background-color: gray;
  display: flex;
  justify-content: center;
  align-items: center;
  & > section {
    width: 500px;
    height: auto;
    & > div {
      text-align: center;
    }
    & > div:nth-child(2) {
      margin-top: -30px;
      color: white;
    }
  }
`;
