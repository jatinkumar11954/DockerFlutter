eval $(ssh-agent)
ssh-add ~/.ssh/git
git add .
git commit -m $1
git push

# mv android/test.txt android/test1.txt
# num=0
# name=0
# num=$(ls build/app/outputs/apk/release/ | sed -e s/[^0-9]//g | sort -rn | head -n 1 )
# num=`expr $num + 1`
# name=`expr $num % 100`
# echo $name

# mv build/app/outputs/apk/release/apk-release.apk build/app/outputs/apk/release/VareV_1_0_$name.apk