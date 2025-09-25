import "styled-components";
import theme from ".";

declare module "styled-components" {
  type themeType = typeof theme;
  export interface DefaultTheme extends themeType {}
}
