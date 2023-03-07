import {
  Callback,
  CustomMessageSignUpTriggerEvent,
  Context,
  Handler,
} from "aws-lambda";

const baseUrl = process.env.BASE_URL;

export const handler: Handler<CustomMessageSignUpTriggerEvent> = (
  event: CustomMessageSignUpTriggerEvent,
  context: Context,
  callback: Callback
): void => {
  const { codeParameter } = event.request;
  const { /* userName ,*/ region } = event;
  const { clientId } = event.callerContext;
  // const email = encodeURIComponent(event.request.userAttributes.email);
  // const firstName = encodeURIComponent(event.request.userAttributes.name);
  // const lastName = encodeURIComponent(
  //   event.request.userAttributes.family_name
  // );

  const url = `${baseUrl}/verification`;
  const link = `<a href="${url}?code=${codeParameter}&clientId=${clientId}&region=${region}" target="_blank">here</a>`;
  event.response.emailSubject = "Your verification link";
  event.response.emailMessage = `Thank you for signing up. Follow ${link} to verify your email.`;

  callback(null, event);
};
