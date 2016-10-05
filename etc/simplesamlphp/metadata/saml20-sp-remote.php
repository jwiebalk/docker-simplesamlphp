<?php
$metadata['https://10.0.1.106'] = array (
  'entityid' => 'https://10.0.1.106',
  'contacts' =>
  array (
  ),
  'metadata-set' => 'saml20-sp-remote',
  'expire' => 1968350830,
  'AssertionConsumerService' =>
  array (
    0 =>
    array (
      'Binding' => 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST',
      'Location' => 'https://10.0.1.106/saml/consume',
      'index' => 0,
      'isDefault' => true,
    ),
  ),
  'SingleLogoutService' =>
  array (
  ),
  'NameIDFormat' => 'urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified',
  'simplesaml.nameidattribute' => 'NameID',
  'keys' =>
  array (
    0 =>
    array (
      'encryption' => false,
      'signing' => true,
      'certificate' => '/var/simplesamlphp/cert/10.0.1.106.crt',
      'type' => 'X509Certificate',
    ),
  ),
  'validate.authnrequest' => false,
  'saml20.sign.assertion' => false,
  'assertion.encryption' => false,
  'certificate' => '/var/simplesamlphp/cert/10.0.1.106.crt',
);
