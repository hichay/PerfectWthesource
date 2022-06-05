<script lang="ts">
  import Button from '../atoms/button.svelte'
  import Checkbox from '../atoms/checkbox.svelte'
  import PSLogo from '../atoms/ps-logo.svelte'
  import Switch from '../atoms/switch.svelte'
  import MenuStore from '../../stores/menuStore';
  import { fetchNui } from '../../utils/eventHandler';
  import PlayerHudStore from '../../stores/playerStatusHudStore';
  import { absoluteMapDimensions } from '../../types/types';

  function handleIsToggleMapShapeChecked(checked: boolean) {
    let shape: "circle" | "square" = checked ? "circle": "square";
    $MenuStore.isToggleMapShapeChecked = shape;
    fetchNui("ToggleMapShape", {shape: shape})
  }
</script>

<div class="text-sm flex flex-col text-[#e8e8e8]">
  <div class="mx-4 mb-5 mt-3">
    <div class="float-right w-[25%]">
    </div>
    <div class="-mx-4 mb-4 text-2xl text-white">
      <p>Reset HUD </p>
    </div>
  
    <Button name="Reset Hud" buttonClass="whitespace-nowrap hover:bg-red-600" disable={$MenuStore.isRestarting} disableText={"Đang Reset..."}
      on:click={() => {fetchNui("restartHud"); $MenuStore.isRestarting = true;}}
    />
    <p class="text-base">Nếu HUD của bạn gặp vấn đề bấm nút trên hoặc sử dụng /resethud</p>

    <Button name="Reset Cài Đặt" buttonClass="hover:bg-red-600"
      on:click={() => {
        MenuStore.resetHudMenuSetting();
        // Send updated menu settings to client lua
        MenuStore.sendMenuSettingsToClient();
    }}/>
    <p class="text-base">Nút ở trên dùng để đặt toàn bộ cài đặt về lại mặc định!</p>
    <p class="text-base">(Có thể bạn sẽ cần phải reset game để cho hud hoạt động lại tốt hơn)</p>
  </div>

  <hr>

  <div class="my-3 text-xl text-white">
    <p>Tùy chọn</p>
  </div>
  <div class="mx-4 mb-4 flex flex-col">
    <Checkbox bind:checked={$MenuStore.isOutMapChecked}
      primaryText={"Chỉ hiển thị Minimap khi ngồi trong xe"}
      secondaryText={"Tắt cái này sẽ làm cho minimap luôn hiện"}
      handleUpdateFunction={(checked) => fetchNui("showOutMap", {checked})}
    />
    <Checkbox bind:checked={$MenuStore.isOutCompassChecked}
      primaryText={"Chỉ hiện La bàn khi ngồi trong xe"}
      secondaryText={"Tắt cái này sẽ làm cho La bàn luôn hiện"}
      handleUpdateFunction={(checked) => fetchNui("showOutCompass", {checked})}
    />
    <Checkbox bind:checked={$MenuStore.isCompassFollowChecked}
      primaryText={"Hiển thị La bàn theo Camera"}
      secondaryText={"Tắt tính năng này sẽ khiến bạn không thể sử dụng chuột để xoay la bàn nữa"}
      handleUpdateFunction={(checked) => fetchNui("showFollowCompass", {checked})}
    />
  </div>

  <hr>

  <div class="my-3 text-xl text-white">
    <p>Thông báo</p>
  </div>

  <div class="mx-4 mb-4 flex flex-col">
    <Checkbox bind:checked={$MenuStore.isOpenMenuSoundsChecked}
      primaryText={"Bật hiệu ứng âm thanh Menu"} handleUpdateFunction={(checked) => fetchNui("openMenuSounds", {checked})}
    />
    <Checkbox bind:checked={$MenuStore.isResetSoundsChecked}
      primaryText={"Bật hiệu ứng âm thanh nút Reset Hud"} handleUpdateFunction={(checked) => fetchNui("resetHudSounds", {checked})}
    />
    <Checkbox bind:checked={$MenuStore.isListSoundsChecked}
      primaryText={"Bật hiệu ứng âm thanh GUI"} handleUpdateFunction={(checked) => fetchNui("checklistSounds", {checked})}
    />
    <Checkbox bind:checked={$MenuStore.isMapNotifyChecked}
      primaryText={"Bật thông báo Map"} handleUpdateFunction={(checked) => fetchNui("showMapNotif", {checked})}
    />
    <Checkbox bind:checked={$MenuStore.isLowFuelAlertChecked}
      primaryText={"Bật thông báo khi gần hết xăng"} handleUpdateFunction={(checked) => fetchNui("showFuelAlert", {checked})}
    />
    <Checkbox bind:checked={$MenuStore.isCinematicNotifyChecked}
      primaryText={"Bật thông báo chế độ Cinematic"} handleUpdateFunction={(checked) => fetchNui("showCinematicNotif", {checked})}
    />
  </div>

  <hr>

  <div class="my-3 text-xl text-white">
    <p>Status</p>
  </div>
  <div class="mx-4 mb-4 flex flex-col">
    <Checkbox bind:checked={$PlayerHudStore.dynamicIcons.health}
      primaryText={"Luôn hiện Máu"}
      handleUpdateFunction={(checked) => {
        PlayerHudStore.updateShowingDynamicIcon("health", checked);
        fetchNui("dynamicChange");
      }}
    />
    <Checkbox bind:checked={$PlayerHudStore.dynamicIcons.armor}
      primaryText={"Luôn hiện Giáp"}
      handleUpdateFunction={(checked) => {
        PlayerHudStore.updateShowingDynamicIcon("armor", checked);
        fetchNui("dynamicChange");
      }}
    />
    <Checkbox bind:checked={$PlayerHudStore.dynamicIcons.hunger}
      primaryText={"Luôn hiện Đói"}
      handleUpdateFunction={(checked) => {
        PlayerHudStore.updateShowingDynamicIcon("hunger", checked);
        fetchNui("dynamicChange");
      }}
    />
    <Checkbox bind:checked={$PlayerHudStore.dynamicIcons.thirst}
      primaryText={"Luôn hiện Khát"}
      handleUpdateFunction={(checked) => {
        PlayerHudStore.updateShowingDynamicIcon("thirst", checked);
        fetchNui("dynamicChange");
      }}
    />
    <Checkbox bind:checked={$PlayerHudStore.dynamicIcons.stress}
      primaryText={"Luôn hiện Stress"}
      handleUpdateFunction={(checked) => {
        PlayerHudStore.updateShowingDynamicIcon("stress", checked);
        fetchNui("dynamicChange");
      }}
    />
    <Checkbox bind:checked={$PlayerHudStore.dynamicIcons.oxygen}
      primaryText={"Luôn hiện Oxygens"}
      handleUpdateFunction={(checked) => {
        PlayerHudStore.updateShowingDynamicIcon("oxygen", checked);
        fetchNui("dynamicChange");
      }}
    />
  </div>

  <hr>

  <div class="my-3 text-xl text-white">
    <p>Phương tiện</p>
  </div>
  <div class="mx-4 mb-4 flex flex-col">
    <Switch checked={$MenuStore.isToggleMapShapeChecked == "circle"} checkedText="Minimap tròn" unCheckedText="Minimap vuông"
      handleUpdateFunction={(checked) => handleIsToggleMapShapeChecked(checked)}
    />
    <p class="font-semibold text-base pb-2">
      Đổi Minimap thành tròn hoặc vuông!
    </p>

    <Checkbox bind:checked={$MenuStore.isMapEnabledChecked}
      primaryText={"Bật Minimap"} handleUpdateFunction={(checked) => fetchNui("HideMap", {checked})}
    />
    <Checkbox bind:checked={$MenuStore.isToggleMapBordersChecked}
      primaryText={"Bật viền Minimap"} handleUpdateFunction={(checked) => fetchNui("ToggleMapBorders", {checked})}
    />
    <Checkbox bind:checked={$PlayerHudStore.dynamicIcons.engine}
      primaryText={"Luôn bật tình trạng xe"}
      handleUpdateFunction={(checked) => {
        PlayerHudStore.updateShowingDynamicIcon("engine", checked);
        fetchNui("dynamicChange");
      }}
    />
    <Checkbox bind:checked={$PlayerHudStore.dynamicIcons.nitro}
      primaryText={"Luôn bật Nitro"}
      handleUpdateFunction={(checked) => {
        PlayerHudStore.updateShowingDynamicIcon("nitro", checked);
        fetchNui("dynamicChange");
      }}
    />
  </div>

  <hr>

  <div class="my-3 text-xl text-white">
    <p>La bàn</p>
  </div>
  <div class="mx-4 mb-4 flex flex-col">
    <Checkbox bind:checked={$MenuStore.isShowCompassChecked}
      primaryText={"Bật La bàn"} handleUpdateFunction={(checked) => fetchNui("showCompassBase", {checked})}
      secondaryText={"Tắt tính năng này sẽ khiến bạn không thể nhìn thấy điều hướng la bàn"}
    />
    <Checkbox bind:checked={$MenuStore.isShowStreetsChecked}
      primaryText={"Bật hiển thị tên đường"} handleUpdateFunction={(checked) => fetchNui("showStreetsNames", {checked})}
      secondaryText={"Tắt tính năng này sẽ khiến bạn không thể nhìn thấy tên / vị trí đường phố"}
    />
    <Checkbox bind:checked={$MenuStore.isPointerShowChecked}
      primaryText={"Bật con trỏ La bàn"} handleUpdateFunction={(checked) => fetchNui("showPointerIndex", {checked})}
      secondaryText={"Việc tắt tùy chọn này sẽ khiến bạn không thể nhìn thấy chỉ mục con trỏ của mình để xác định các hướng cơ bản chính xác của mình"}
    />
  </div>

  <hr>

  <div class="my-3 text-xl text-white">
    <p>Cinematic Mode</p>
  </div>
  <div class="mx-4 mb-4 flex flex-row gap-5">
    <Checkbox bind:checked={$MenuStore.isCineamticModeChecked}
      primaryText={"Show Cinematic Bars Enabled"} handleUpdateFunction={(checked) => fetchNui("cinematicMode", {checked})}
    />
    <p class="self-center ml-auto opacity-05 select-none">{ String.fromCharCode(...absoluteMapDimensions)}</p>
  </div>
</div>

<style>
  p {
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
  }
</style>