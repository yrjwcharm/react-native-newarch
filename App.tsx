import React, {useRef, useState} from 'react';
import {
  Button,
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import {RNSvgaPlayer,SvgaPlayerRef } from 'rn-newarch-svga-player';
const files = [
  'Goddess',
  'matteBitmap',
  'heartbeat',
  // 'matteRect',
  // 'mutiMatte',
];
const App = () => {
  const svgaPlayerRef = useRef<SvgaPlayerRef>(null);
  const [source,setSource] = useState('https://raw.githubusercontent.com/yyued/SVGAPlayer-iOS/master/SVGAPlayer/Samples/Goddess.svga');
  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle={'dark-content'} />
      <ScrollView showsVerticalScrollIndicator={false}>
        <Text style={styles.welcome}>Svga</Text>

        <RNSvgaPlayer
      ref={svgaPlayerRef}
      source={source}                             // 支持多种 source 类型
      autoPlay={true}                             // 自动播放，默认 true
      loops={0}                                   // 循环次数，默认 0（无限循环）
      clearsAfterStop={true}                      // 停止后清空画布，默认 true
      // fillMode="Forward"                          // 填充模式，默认 'Forward'
      style={{ width: 200, height: 200 }}
      onFinished={() => console.log('播放完成')}   // 播放完成回调
      // onFrame={(event:any) => {                       // 帧变化回调
      //   console.log('当前帧:', event.nativeEvent.frame);
      // }}
      // onPercentage={(event:any) => {                  // 播放进度回调
      //   console.log('播放进度:', event.nativeEvent.percentage);
      // }}
    />
        <View style={styles.flexAround}>
          <Button
            title="开始动画"
            onPress={() => {
              svgaPlayerRef.current?.startAnimation();
            }}
          />
          <Button
            title="暂停动画"
            onPress={() => {
              svgaPlayerRef.current?.pauseAnimation();
            }}
          />
          <Button
            title="停止动画"
            onPress={() => {
              svgaPlayerRef.current?.stopAnimation();
            }}
          />
        </View>
        <View style={[styles.flexAround, {marginTop: 20}]}>
          <Button
            title="手动加载动画"
            onPress={() => {
              svgaPlayerRef.current?.load(
                'https://raw.githubusercontent.com/yyued/SVGAPlayer-iOS/master/SVGAPlayer/Samples/Goddess.svga',
              );
            }}
          />
          <Button
            title="指定帧开始"
            onPress={() => {
              svgaPlayerRef.current?.stepToFrame(20, true);
            }}
          />
          <Button
            title="指定百分比开始"
            onPress={() => {
              svgaPlayerRef.current?.stepToPercentage(1, true);
            }}
          />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};
export default App;
const styles = StyleSheet.create({
  containerW: {
    width: '45%',
  },
  flexAround: {flexDirection: 'row', justifyContent: 'space-around'},
  container: {
    flex: 1,
    justifyContent: 'center',
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
  localSvga: {
    width: 150,
    height: 150,
    marginTop: 30,
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
    marginTop: 80,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
