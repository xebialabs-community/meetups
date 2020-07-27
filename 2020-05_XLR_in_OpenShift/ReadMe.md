## XL Release Config for Openshift ##
Use `oc create -f 'filename'` to add these to your openshift project
Make sure your namespace is updated in all the files so instead of
`demo-project` it would be your project name.
You must be admin to create pvs. You will need to have a conf file
that your pv can point to to create a deployment other than the intital deployment
This is for xl release tag 9.6 if you want to use a different image you must
update the image.yaml file with the tag you would like. (latetst is not a supported
tag under xl release)
