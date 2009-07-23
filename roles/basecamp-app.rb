name "basecamp-app"
description "Basecamp Application Server"

override_attributes 'apache' => { 'deflate' => { 'disable' => true }}
