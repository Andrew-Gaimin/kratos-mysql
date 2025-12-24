local claims = std.extVar('claims');
{
  identity: {
    traits: {
      // Jackson (the bridge) sends back an 'email' claim from the SAML provider
      email: claims.email,
    },
  },
}