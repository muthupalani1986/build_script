#!/bin/bash
cd /home/veyoga/public_html/invoice_workspace/invoice-api
changed=0
git remote update && git status -uno | grep -q 'Your branch is behind' && changed=1
if [ $changed = 1 ]; then
    git pull
    echo "Updated successfully"
    sourceDir=/home/veyoga/public_html/invoice_workspace/invoice-api/.
    destDir=/home/veyoga/public_html/api_build
    sudo rm -r $destDir/*
    cp -r $sourceDir $destDir
    cd $destDir
    npm install
    pm2 restart all
    echo "Deployment success"
    mail -s "Invoice API:Deployment Success" muthupalani1986@gmail.com -c senthilnbm@gmail.com <<< 'Invoice API deployment completed successfully'
else
    echo "Up-to-date"
fi
cd /home/veyoga/public_html/invoice_workspace/invoice-system
changed=0
git remote update && git status -uno | grep -q 'Your branch is behind' && changed=1
if [ $changed = 1 ]; then
    git pull
    echo "Updated successfully"
    npm install && npm run build-prod
    echo "Build success";
    sourceDir=/home/veyoga/public_html/invoice_workspace/invoice-system/dist/fuse/.
    destDir=/home/veyoga/public_html/ui_build
    sudo rm -r $destDir/*
    cp -r $sourceDir $destDir
    echo "Deployment success"
    mail -s "Invoice UI:Deployment Success" muthupalani1986@gmail.com -c senthilnbm@gmail.com <<< 'Invoice UI deployment completed successfully'
else
    echo "Up-to-date"
fi

